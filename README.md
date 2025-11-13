# 🌉 GudanBridge Care
### Bem-estar, saúde mental e desenvolvimento humano para o futuro do trabalho.

O **GudanBridge Care** é um aplicativo criado para apoiar colaboradores e organizações no desenvolvimento de um ambiente corporativo mais saudável, sustentável e equilibrado. Ele integra tecnologia, inteligência emocional, automações de dados e experiências personalizadas para promover qualidade de vida no trabalho.

Este projeto foi desenvolvido como parte da **Global Solution 2 – FIAP**, unindo tecnologia, propósito e impacto humano.

---

## ✨ Funcionalidades Principais

### ✅ 1. Check-in Emocional Diário
Ferramenta de registro rápido do estado emocional do colaborador:
- Humor (1 a 5)
- Energia (1 a 10)
- Carga de trabalho
- Comentários opcionais

Esses dados alimentam indicadores internos e insights automáticos.

---

### ✅ 2. Jornada de Hábitos Saudáveis
- Catálogo de micro-hábitos (pausa consciente, alongamento, respiração etc.)
- Criação de planos de hábitos por colaborador
- Registro das execuções diárias
- Indicadores de consistência e adesão

---

### ✅ 3. Metas de Desenvolvimento
- Metas pessoais e profissionais
- Gestão de ações vinculadas
- Acompanhamento do progresso
- Controle de realização semanal/mensal

---

### ✅ 4. Insights de Bem-Estar
- Recomendações baseadas nos últimos check-ins
- Análise de padrões comportamentais
- Orientações para equilíbrio emocional e produtividade

---

### ✅ 5. Perfil do Colaborador
Painel completo com indicadores:
- “Roda de bem-estar” (progresso geral)
- Evolução do humor
- Energia média
- Equilíbrio vida-trabalho
- Crescimento profissional

Inclui login simples (e-mail + senha) para apresentação.

---

# 🧠 Arquitetura Técnica

O projeto segue uma arquitetura moderna baseada em **Flutter + Riverpod** e banco de dados **Oracle** com PL/SQL para automações inteligentes.

---

## 📱 Frontend — Flutter

### Principais Tecnologias
- **Flutter 3.19+**
- **Dart**
- **Riverpod**
- **Material Design 3**
- **Arquitetura modular por Features**

### Benefícios
- Multiplataforma
- Alta performance
- UI rica
- Fácil escalabilidade

---

## 🗄️ Backend / Data Layer — Oracle + PL/SQL

### Automações criadas
- REGISTRAR_USO_APP
- CALCULAR_METRICAS_DIARIAS
- GERAR_ALERTAS_BEM_ESTAR

Arquivo SQL completo: `gudanbridge_der_plsql.sql`

---

# 🧩 Estrutura do Projeto

```
lib/
 ├── core/
 ├── features/
 │    ├── checkin/
 │    ├── habits/
 │    ├── goals/
 │    ├── insights/
 │    └── profile/
 └── main.dart
```

---

# 🚀 Como Executar o Projeto

## Requisitos
- Flutter 3.19+
- Android Studio ou VSCode

## Passos
```
flutter pub get
flutter run
```

---

# 📄 Documentação Complementar
- GudanBridge_DER_Documentacao.pdf
- gudanbridge_der_plsql.sql

---

# 🤝 Equipe
Time multidisciplinar de 5 integrantes comprometidos com inovação, bem-estar e tecnologia.

---

# ⭐ Contribua
Se este projeto te inspirou, deixe uma estrela!
