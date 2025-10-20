# Sırlar için çıktı klasörlerini oluştur:
mkdir -p "__ANALYSIS/deleted_files"
mkdir -p "__ANALYSIS/unreachable_blobs"

# --- Adım 3.1: Silinmiş Dosyaları Geri Yükle ---
# Her commit'i kontrol ederek silinmiş dosyaları bulup diskimize kaydeder.
echo "1/3: Silinmiş dosyalar geri yükleniyor..."
git rev-list --all | while read -r commit; do
    parent_commit=$(git log --pretty=format:"%P" -n 1 "$commit" | awk '{print $1}')
    if [ -z "$parent_commit" ]; then continue; fi # İlk commit'in parent'ı olmaz

    git diff --name-status "$parent_commit" "$commit" | while read -r file_status file_path; do
        if [ "$file_status" = "D" ]; then # Eğer dosya silinmişse (D = Deleted)
            # Güvenli bir dosya adı oluştur ve dosyayı kaydet
            safe_file_name=$(echo "$file_path" | sed 's/[^a-zA-Z0-9._-]/_/g')
            output_file="__ANALYSIS/deleted_files/${commit}___${safe_file_name}"
            if [ ! -f "$output_file" ]; then # Aynı dosyayı tekrar çekmemek için kontrol
                git show "$parent_commit:$file_path" > "$output_file" 2>/dev/null
                if [ $? -eq 0 ]; then # İşlem başarılıysa
                    echo "  Geri yüklendi: $file_path (commit: $commit)"
                fi
            fi
        fi
    done
done
echo "Silinmiş dosyalar geri yüklendi."

# --- Adım 3.2: .pack Dosyalarını Aç ---
# Git'in optimize edilmiş depolama biçimi olan .pack dosyalarının içindeki objeleri çıkarır.
echo "2/3: .pack dosyaları açılıyor..."
find .git/objects/pack -name "*.pack" -print0 | while IFS= read -r -d $'\0' pack_file; do
    git unpack-objects < "$pack_file" >/dev/null 2>&1
    if [ $? -eq 0 ]; then # İşlem başarılıysa
        echo "  Açıldı: $pack_file"
    fi
done
echo ".pack dosyaları açıldı."

# --- Adım 3.3: Dangling Objeleri Çıkar ---
# Git geçmişinde artık hiçbir referans tarafından gösterilmeyen (unutulmuş) objeleri bulup diskimize kaydeder.
echo "3/3: Dangling (ulaşılamaz) objeler çıkarılıyor..."
git fsck --unreachable --dangling --no-reflogs --full - | grep 'unreachable blob' | awk '{print $3}' | while read h; do
    output_blob_file="__ANALYSIS/unreachable_blobs/$h.blob"
    if [ ! -f "$output_blob_file" ]; then # Aynı objeyi tekrar çekmemek için kontrol
        git cat-file -p "$h" > "$output_blob_file" 2>/dev/null
        if [ $? -eq 0 ]; then # İşlem başarılıysa
            echo "  Çıkarıldı dangling blob: $h"
        fi
    fi
done
echo "Dangling objeler çıkarıldı."

echo "Git geçmişi analizi tamamlandı."
