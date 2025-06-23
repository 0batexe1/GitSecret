# GitSecret

Proje Hakkında

Bu proje, Git deposu geçmişinde gizlenmiş hassas bilgileri (API anahtarları, token'lar, kimlik bilgileri vb.) ortaya çıkarmak için tasarlanmış basit ama etkili bir otomasyon aracıdır. Silinmiş dosyaların, .pack dosyalarının ve "dangling" (ulaşılamaz) Git objelerinin derinlemesine analizini yaparak, standart sır tarama araçlarının gözden kaçırabileceği bilgileri kurtarır ve TruffleHog ile bu kurtarılan veriler üzerinde aktif sır araması yapar.

Bu araç, özellikle bug bounty avcıları, güvenlik araştırmacıları ve sızma testleri yapanlar için Git geçmişindeki potansiyel bilgi sızıntılarını tespit etmede kritik bir rol oynar.

Amaç ve Hedef Kitle

Bu projenin temel amacı, geliştiricilerin ve güvenlik uzmanlarının Git depolarındaki hassas veri sızıntılarını daha etkili bir şekilde tespit etmelerine yardımcı olmaktır. Özellikle şu kitlelere hitap eder:

    Bug Bounty Avcıları: Hedef programlarda gizli kalmış sırları bulmak için.
    Güvenlik Araştırmacıları: Açık kaynak projelerde veya dahili kod tabanlarında zafiyet avlamak için.
    DevOps ve Geliştiriciler: CI/CD süreçlerine entegre ederek kendi kod tabanlarındaki yanlışlıkla sızdırılmış sırları proaktif olarak tespit etmek için.

Özellikler

    Derinlemesine Git Geçmişi Analizi: Commit'ler arası farkları izleyerek silinmiş dosyaları kurtarır; Git'in depolama optimizasyonu olan .pack dosyalarının içeriğini açar; Git veritabanında referanssız kalmış "dangling" objeleri bulur ve çıkarır.
    Entegre Sır Taraması: Kurtarılan ve mevcut tüm veriler üzerinde endüstri standardı sır tarama aracı TruffleHog ile only-verified modunda (yalnızca aktif sırlar için) kapsamlı bir tarama yapar.
    Basit Kullanım: Tek bir Bash script'i ile tüm analiz ve tarama sürecini başlatır.
    Esneklik: Tek bir depoda veya birden fazla depoda kolayca çalıştırılabilir.

Gereklilikler

Bu aracı kullanmak için sisteminizde aşağıdaki yazılımların kurulu olması gerekir:

    Git: Depoları klonlamak ve Git geçmişini analiz etmek için.
    Python 3 ve Pip: TruffleHog'u kurmak ve çalıştırmak için.
    TruffleHog: Sır tarama motoru. pip install trufflehog komutu ile kurulabilir.
    Bash: Script'i çalıştırmak için. Çoğu Linux ve macOS sisteminde varsayılan olarak bulunur. Windows'ta WSL (Windows Subsystem for Linux) veya Git Bash üzerinden kullanılabilir.

Kurulum ve Kullanım

    TruffleHog Kurulumu:
    Sisteminizde Python ve Pip kurulu olduğundan emin olun. Ardından TruffleHog'u aşağıdaki komutla yükleyin:
    pip install trufflehog

    Hedef Depoyu Klonlayın:
    Analiz etmek istediğiniz Git deposunu yerel makinenize klonlayın. Örneğin:
    git clone https://github.com/hedef/ornek_repo.git
    cd ornek_repo

    Script Dosyasını İndirin/Oluşturun:
    Bu projenin GitHub deposundan 'analyze_git_history.sh' adlı script dosyasını indirin ve klonladığınız deponun ana dizinine (yani 'ornek_repo' klasörünün içine) yerleştirin.

    Script'i Çalıştırın:
    Deponun ana dizinindeyken script'e çalıştırma izni verin ve çalıştırın:
    chmod +x analyze_git_history.sh
    ./analyze_git_history.sh

Script çalışmaya başladığında terminalinizde ilerleme mesajlarını göreceksiniz. Analiz ve tarama süresi, deponun boyutuna ve geçmişine bağlı olarak değişebilir.

Bulguları Değerlendirme

Tarama tamamlandıktan sonra, deponun ana klasörünün bir üstündeki dizinde, '[depo_adı]_secrets.json' formatında bir JSON dosyası bulacaksınız (örneğin, 'ornek_repo_secrets.json'). Bu JSON dosyası, TruffleHog'un 'Verified: true' olarak işaretlediği tüm potansiyel aktif sırları içerecektir.

Her bulguyu manuel olarak doğrulamanız ve potansiyel etki alanını anlamanız kritik öneme sahiptir. Unutmayın, bazı token'lar test amaçlı veya düşük yetkili olabilir ve bir güvenlik zafiyeti teşkil etmeyebilir.

Katkıda Bulunma

Proje daha fazla geliştirmeye açık! Geri bildirimleriniz, hata raporlarınız ve katkılarınız her zaman açığız. Bir çekme isteği (pull request) göndermeden önce lütfen mevcut sorunları kontrol edin veya yeni bir sorun açın.

Lisans

Bu proje MIT Lisansı altında yayınlanmıştır. Daha fazla bilgi için 'LICENSE' dosyasına bakın. Lisansın eklenmesi, projenin açık kaynak olarak nasıl kullanılabileceği, değiştirilebileceği ve dağıtılabileceği konusunda yasal netlik sağlar. Kullanıcılara projenizi özgürce kullanma izni verirken, sizi olası yasal sorumluluklardan korur. Lisanssız bir açık kaynak projesi yayınlamak, yasal olarak tüm hakların saklı olduğu anlamına gelir ve bu da projenizin benimsenmesini ve katkı almasını ciddi şekilde kısıtlayabilir.

İletişim

Sorularınız, önerileriniz veya işbirliği talepleriniz için bana [e-posta adresiniz veya GitHub profil linkiniz] üzerinden ulaşabilirsiniz.

English Version

Git Secret Digger: In-Depth Repo Analysis and Secret Scanning

About The Project

This project provides a simple yet powerful automation to uncover sensitive information (API keys, tokens, credentials, etc.) hidden within Git repository history. It performs a deep analysis of deleted files, .pack files, and "dangling" (unreachable) Git objects, recovering data that standard secret scanning tools might miss. Finally, it leverages TruffleHog to scan these recovered as well as existing files for active secrets.

This tool is particularly useful for bug bounty hunters, security researchers, and penetration testers looking to identify potential information leaks in Git repositories.

Purpose and Target Audience

The primary goal of this project is to help developers and security professionals more effectively identify sensitive data leaks in Git repositories. It specifically targets the following audiences:

    Bug Bounty Hunters: To find hidden secrets in target programs.
    Security Researchers: To discover vulnerabilities in open-source projects or internal codebases.
    DevOps and Developers: To integrate into CI/CD pipelines for proactive detection of accidentally leaked secrets in their own codebases.

Features

    In-Depth Git History Analysis: Recovers deleted files by examining differences between commits; unpacks the contents of Git's optimized storage format (.pack files); identifies and extracts "dangling" objects from the Git database that are no longer referenced by any commit.
    Integrated Secret Scanning: Utilizes TruffleHog, an industry-standard secret scanning tool, to perform a comprehensive scan on all recovered and existing data, specifically in only-verified mode (for active secrets only).
    Simple Usage: Initiates the entire analysis and scanning process with a single Bash script.
    Flexibility: Can be easily run on a single repository or across multiple repositories.

Requirements

To use this tool, the following software must be installed on your system:

    Git: For cloning repositories and analyzing Git history.
    Python 3 and Pip: To install and run TruffleHog.
    TruffleHog: The core secret scanning engine. Can be installed with the command pip install trufflehog.
    Bash: To execute the script. It is typically available by default on most Linux and macOS systems. On Windows, it can be used via WSL (Windows Subsystem for Linux) or Git Bash.

Installation and Usage

    TruffleHog Installation:
    Ensure you have Python and Pip installed on your system. Then, install TruffleHog with the following command:
    pip install trufflehog

    Clone the Target Repository:
    Clone the Git repository you wish to analyze to your local machine. For example:
    git clone https://github.com/target/example_repo.git
    cd example_repo

    Download/Create the Script File:
    Download the 'analyze_git_history.sh' script file from this project's GitHub repository and place it in the root directory of your cloned repository (i.e., inside the 'example_repo' folder).

    Run the Script:
    While in the root directory of the repository, give the script execute permissions and run it:
    chmod +x analyze_git_history.sh
    ./analyze_git_history.sh

When the script starts, you'll see progress messages in your terminal. The analysis and scanning time may vary depending on the repository's size and history.

Evaluating Findings

After the scan is complete, you will find a JSON file named '[repo_name]_secrets.json' (e.g., 'example_repo_secrets.json') in the parent directory of the repository's root folder. This JSON file will contain all potential active secrets flagged by TruffleHog as 'Verified: true'.

It is crucial to manually verify each finding and understand its potential impact. Keep in mind that some tokens might be for testing purposes or have low privileges, and thus may not constitute a security vulnerability.

Contributing

The project is open for further development! Your feedback, bug reports, and contributions are always welcome. Please check for existing issues or open a new one before submitting a pull request.

License

This project is licensed under the MIT License. See the 'LICENSE' file for more details. Including a license provides legal clarity on how your open-source project can be used, modified, and distributed. It grants users the freedom to utilize your project while protecting you from potential legal liabilities. Publishing an open-source project without a license implies that all rights are reserved by default, which can severely restrict the adoption and contribution to your project.

Contact

For any questions, suggestions, or collaboration inquiries, feel free to reach out to me via [your email address or GitHub profile link].
