
---

# 🔐 GitSecret

## 📘 Proje Hakkında

**GitSecret**, Git deposu geçmişinde gizlenmiş hassas bilgileri (API anahtarları, token'lar, kimlik bilgileri vb.) ortaya çıkarmak için tasarlanmış basit ama etkili bir otomasyon aracıdır.

Silinmiş dosyaların, `.pack` dosyalarının ve “dangling” (ulaşılamaz) Git objelerinin derinlemesine analizini yaparak, standart sır tarama araçlarının gözden kaçırabileceği bilgileri kurtarır ve **TruffleHog** ile bu kurtarılan veriler üzerinde aktif sır araması yapar.

Bu araç, özellikle **bug bounty avcıları**, **güvenlik araştırmacıları** ve **sızma testi uzmanları** için Git geçmişindeki potansiyel bilgi sızıntılarını tespit etmede kritik bir rol oynar.

---

## 🎯 Amaç ve Hedef Kitle

Bu projenin temel amacı, geliştiricilerin ve güvenlik uzmanlarının Git depolarındaki **hassas veri sızıntılarını** daha etkili bir şekilde tespit etmelerine yardımcı olmaktır.

Özellikle şu kitlelere hitap eder:

* 🕵️‍♂️ **Bug Bounty Avcıları:** Hedef programlarda gizli kalmış sırları bulmak için.
* 🔬 **Güvenlik Araştırmacıları:** Açık kaynak projelerde veya dahili kod tabanlarında zafiyet avlamak için.
* ⚙️ **DevOps ve Geliştiriciler:** CI/CD süreçlerine entegre ederek kendi kod tabanlarındaki yanlışlıkla sızdırılmış sırları proaktif olarak tespit etmek için.

---

## ⚡ Özellikler

* 🧩 **Derinlemesine Git Geçmişi Analizi:**
  Commit'ler arası farkları izleyerek silinmiş dosyaları kurtarır, Git’in `.pack` dosyalarını açar ve “dangling” objeleri çıkarır.

* 🔍 **Entegre Sır Taraması:**
  Kurtarılan ve mevcut tüm veriler üzerinde **TruffleHog** ile *only-verified* modunda (yalnızca aktif sırlar) tarama yapar.

* 💡 **Basit Kullanım:**
  Tek bir Bash script'iyle tüm analiz sürecini otomatik başlatır.

* 🧠 **Esnek Yapı:**
  Tek bir depoda veya birden fazla depoda kolayca çalıştırılabilir.

---

## 🧰 Gereklilikler

Bu aracı kullanmak için sisteminizde aşağıdaki yazılımların kurulu olması gerekir:

| Gereklilik         | Açıklama                                                                                            |
| ------------------ | --------------------------------------------------------------------------------------------------- |
| **Git**            | Depoları klonlamak ve geçmişi analiz etmek için.                                                    |
| **Python 3 & Pip** | TruffleHog kurulumu ve çalışması için.                                                              |
| **TruffleHog**     | Sır tarama motoru. Kurulum: `pip install trufflehog`                                                |
| **Bash**           | Script'i çalıştırmak için. (Linux/macOS varsayılan; Windows için WSL veya Git Bash kullanılabilir.) |

---

## ⚙️ Kurulum ve Kullanım

1. **TruffleHog Kurulumu:**

   ```bash
   pip install trufflehog
   ```

2. **Hedef Depoyu Klonlayın:**

   ```bash
   git clone https://github.com/hedef/ornek_repo.git
   cd ornek_repo
   ```

3. **Script Dosyasını Ekleyin:**
   Bu projenin deposundan `analyze_git_history.sh` dosyasını indirip, klonladığınız deponun kök dizinine yerleştirin.

4. **Çalıştırma:**

   ```bash
   chmod +x analyze_git_history.sh
   ./analyze_git_history.sh
   ```

🧾 Script çalışmaya başladığında terminalde ilerleme mesajlarını görebilirsiniz.
Analiz süresi, deponun boyutuna ve commit geçmişine göre değişebilir.

---

## 📊 Bulguları Değerlendirme

Tarama tamamlandıktan sonra, deponun bulunduğu klasörün **bir üst dizininde**
`[depo_adı]_secrets.json` formatında bir dosya oluşacaktır (örnek: `ornek_repo_secrets.json`).

Bu JSON dosyasında, **TruffleHog’un “Verified: true”** olarak işaretlediği tüm potansiyel **aktif sırlar** listelenir.

> 💡 Her bulguyu manuel olarak doğrulamak ve potansiyel etki alanını anlamak çok önemlidir.
> Bazı token’lar test amaçlı veya düşük yetkili olabilir.

---

## 🤝 Katkıda Bulunma

Proje sürekli geliştirilmeye açıktır!
Geri bildirim, hata raporu veya yeni özellik önerileriniz için bir **Issue** açabilir ya da **Pull Request** gönderebilirsiniz.

---

## ⚖️ Lisans

Bu proje **MIT Lisansı** altında yayınlanmıştır.
Lisans dosyası, projenin nasıl kullanılabileceği, değiştirilebileceği ve dağıtılabileceği konusunda yasal netlik sağlar.

> 🧠 Lisans eklemeden açık kaynak paylaşmak, tüm hakların sizde saklı olduğu anlamına gelir — bu da topluluk katkısını sınırlar.

---

## 📬 İletişim

📂 GitHub: [0bat.exe1](https://github.com/0bat.exe1)

---

<p align="center"> <b>💀 Git geçmişinde gizlenmiş sırlar asla kaybolmaz... onları bulmak sizin elinizde.</b> </p> ```

---
