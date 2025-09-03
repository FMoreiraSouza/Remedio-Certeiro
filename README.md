# Remédio Certeiro

<img src="resources/images/app_banner.png" alt="Logo" width="400">

![Flutter](https://img.shields.io/badge/Flutter-3.35.2-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.9.0-blue?logo=dart)

---

## 📃 Descrição

O Remédio Certeiro é uma aplicação Flutter desenvolvida em Dart para gerenciamento de medicamentos, permitindo aos usuários organizar e acompanhar doses de forma prática e segura. A aplicação adota a arquitetura MVVM (Model-View-ViewModel), estruturada em camadas: presentation (interface do usuário e ViewModels), domain (modelos e interfaces de repositório) e data (implementações de repositórios e acesso a dados). Essa organização garante separação de responsabilidades, manutenibilidade e escalabilidade. O aplicativo se integra com o **Appwrite** para autenticação segura, armazenamento de dados e sincronização, além de utilizar notificações locais para lembrar os usuários sobre as próximas doses de medicamentos.

---

## 💻 Tecnologias Utilizadas

- **Dart**: Linguagem de programação principal.
- **Flutter**: Framework para construção de interfaces de usuário multiplataforma.
- **Appwrite**: Backend para autenticação, banco de dados e gerenciamento de dados.
- **SQFLite**: Banco de dados local para armazenamento de informações sobre doses.
- **SharedPreferences**: Persistência local para gerenciamento de sessões.
- **Flutter Local Notifications**: Biblioteca para envio de notificações locais.
- **Provider**: Gerenciamento de estado para controle das camadas da aplicação.

---

## 🛎️ Funcionalidades

- **Autenticação de Usuários**: Login seguro com e-mail e senha, além de cadastro de novos usuários com informações como nome, idade, CPF e telefone.
- **Gerenciamento de Medicamentos**: Cadastro, edição e exclusão de medicamentos com detalhes como nome, dosagem, forma farmacêutica, classe terapêutica, propósito, modo de uso e data de validade.
- **Acompanhamento de Doses**: Visualização de horários de doses em tempo real, com lembretes via notificações locais 5 minutos antes do horário programado.
- **Notificações e Alarmes**: Alertas para doses próximas e alarmes sonoros quando o horário da dose está próximo.
- **Perfil do Usuário**: Exibição de informações pessoais do usuário e opção de logout.
- **Gerenciamento Offline**: Suporte para operação offline com armazenamento local de dados de doses.

---

## ▶️ Como Rodar o Projeto

### Pré-requisitos

- **Flutter** 3.0 ou superior (com Dart incluído).
- **Visual Studio Code** (recomendado) com extensões Flutter e Dart instaladas.
- Conta no [Appwrite](https://appwrite.io/) configurada.

### Clone o repositório

- git clone <URL_DO_PROJETO>

### Configuração do Appwrite

- Crie um projeto no Appwrite:
  - Acesse o Appwrite Cloud e crie um novo projeto.
  - Copie o PROJECT_ID, ENDPOINT, DATABASE_ID, e as IDs das coleções necessárias (users, medicines, pharmaceutical_forms, therapeutic_categories).

### Configure as credenciais:

- Abra o arquivo lib/data/api/app_write_service.dart.
- Atualize o endpoint e o projectId com os valores do seu projeto Appwrite:

### Crie as coleções no Appwrite:

- No painel do Appwrite, crie as seguintes coleções no banco de dados:
  - users: Para armazenar informações do usuário (userId, name, email, age, cpf, phone).
  - medicines: Para armazenar dados dos medicamentos (name, dosage, purpose, useMode, interval, expirationDate, pharmaceuticalForm, therapeuticCategory).
  - pharmaceutical_forms: Para armazenar formas farmacêuticas disponíveis.
  - therapeutic_categories: Para armazenar classes terapêuticas disponíveis.
- Adicione as permissões necessárias para leitura e escrita para usuários autenticados:
- Crie os documentos iniciais:
  - Para as coleções pharmaceutical_forms e therapeutic_categories, insira documentos com o atributo name contendo os valores desejados (ex.: "Comprimido", "Cápsula" para formas farmacêuticas; "Analgésico", "Antibiótico" para classes terapêuticas).

### Configuração do ambiente Flutter

- Instale as dependências:
  - Abra o Visual Studio Code, carregue a pasta remedio-certeiro.
  - No terminal integrado, execute: flutter pub get
- Verifique o ambiente:
  - Execute o comando para verificar a configuração do Flutter: flutter doctor
  - Resolva quaisquer problemas indicados se necessário.

### Configuração do emulador ou dispositivo

#### Emulador:

- No VS Code, clique em Run > Start Debugging (F5) e selecione um emulador Android/iOS (recomendado: Pixel 6 com API 33 para Android).

#### Dispositivo físico:

- Conecte via USB com Modo Desenvolvedor e Depuração USB habilitados ou use Depuração sem fio (em Opções do desenvolvedor no dispositivo).

### Execute o aplicativo

- No VS Code, clique em Run > Run Without Debugging (Ctrl + F5) ou, no terminal, execute: flutter run
- O aplicativo será compilado e executado no emulador ou dispositivo.

## 🎥 Apresentação do Aplicativo

Confira a apresentação do aplicativo: [Apresentação](https://youtu.be/nq1IdgyNeUA)
