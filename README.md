# 🚀 Bliss Challenge – iOS App  

Este projeto foi desenvolvido como parte de um **desafio técnico** e tem como objetivo demonstrar conhecimentos em **SwiftUI, SwiftData, MVVM, Repository Pattern, consumo de APIs, tratamento de erros e boas práticas de UI/UX**.  

---

## ✨ Funcionalidades  

- 🎨 **Botão customizado** para gerar **emojis aleatórios**, com `ProgressView` exibindo o estado de carregamento.  
- 📋 **Listagem de Emojis** vinda da **API ou cache local**, exibindo indicador de loading até a resposta chegar.  
- 💾 **Repository Pattern** implementado para decidir dinamicamente se os dados vêm da cache ou da API.  
- 🔄 **Pull-To-Refresh** na lista de Emojis:  
  - Atualiza os dados diretamente da API e guarda na cache.  
  - Possibilidade de **remover emoji apenas da lista (mantendo no cache)**.  
- 🖼️ **Imagens salvas no banco** (mesmo sabendo que não é a melhor prática) para demonstrar domínio técnico, já que as imagens originais da API eram muito pequenas.  
- 🎭 **Exibição dinâmica** de imagem do Avatar ou Emoji aleatório.  
- 🔍 **Busca de Avatares**:  
  - Repository verifica cache antes de chamar a API.  
  - Exibe **alerta amigável** caso não encontre resultados.  
  - Botão de busca só habilitado quando o campo de texto está preenchido.  
- 🔄 **Pull-To-Refresh na listagem de Avatares** → apaga todos os avatares salvos na cache.  
- 📚 **Listagem paginada dos repositórios da Apple**.  
- 🛠️ **Camada Repository** adicionada para centralizar regras de negócio e tomada de decisão entre cache e API.  
- 🌐 **Endpoints organizados em Enum dinâmico**, facilitando manutenção e escalabilidade.  
- 🖥️ **Logs no console** para visualizar o fluxo de execução e debugging.  

---

## 🛠️ Tecnologias  

- **SwiftUI** → Interface declarativa.  
- **SwiftData** → Persistência local.  
- **MVVM (Model-View-ViewModel)** → Arquitetura para separação de responsabilidades e escalabilidade.  
- **Async/Await + Error Handling** → Operações assíncronas com tratamento de erros robusto.  
- **Repository Pattern** → Manuseio e decisão entre cache e API.  
- **URLSession** → Requisições HTTP nativas do iOS.  
- **GitFlow** → Organização do fluxo de versionamento e branches.  
- **100% Nativo iOS** → Sem frameworks externos.  

---

## 📌 Observações  

- Algumas escolhas, como **salvar imagens diretamente no banco**, foram feitas propositalmente para demonstrar domínio técnico, mesmo não sendo a prática mais recomendada em produção.  

---

## 👨‍💻 Autor  

Desenvolvido por **Jamerson Macedo** ✨ 

# English


# 🚀 Bliss Challenge – iOS App  

This project was developed as part of a **technical challenge** to demonstrate knowledge in **SwiftUI, SwiftData, MVVM, Repository Pattern, API consumption, error handling, and UI/UX best practices**.  

The app is **100% native iOS**, built entirely using Apple's ecosystem.  

---

## ✨ Features  

- 🎨 **Custom button** to generate **random emojis**, with a `ProgressView` showing the loading state.  
- 📋 **Emoji listing** fetched from **API or local cache**, showing a loading indicator until the data arrives.  
- 💾 **Repository Pattern** implemented to dynamically decide whether data comes from cache or API.  
- 🔄 **Pull-To-Refresh** on the Emoji list:  
  - Refreshes data directly from the API and saves it in the cache.  
  - Allows **removing an emoji only from the list (keeping it in the cache)**.  
- 🖼️ **Images saved in the database** (even though not best practice) to demonstrate technical skills, since the API images were very small.  
- 🎭 **Dynamic display** of either Avatar or random Emoji images.  
- 🔍 **Avatar search**:  
  - Repository checks cache before calling the API.  
  - Shows a **friendly alert** if no results are found.  
  - Search button only enabled when the text field is filled.  
- 🔄 **Pull-To-Refresh on Avatar list** → deletes all avatars saved in cache.  
- 📚 **Paginated list of Apple repositories**.  
- 🛠️ **Repository layer** added to centralize business logic and handle decisions between cache and API.  
- 🌐 **Endpoints organized in a dynamic Enum**, facilitating maintenance and scalability.  
- 🖥️ **Console logs** to visualize execution flow and aid debugging.  

---

## 🛠️ Technologies  

- **SwiftUI** → Declarative UI.  
- **SwiftData** → Local persistence.  
- **MVVM (Model-View-ViewModel)** → Architecture for responsibility separation and scalability.  
- **Async/Await + Error Handling** → Asynchronous operations with robust error handling.  
- **Repository Pattern** → Handles data fetching logic and cache/API decision-making.  
- **URLSession** → Native iOS HTTP requests.  
- **GitFlow** → Branching and versioning workflow.  
- **100% Native iOS** → No external frameworks used.  

---

## 📌 Notes  

- Some choices, such as **saving images directly in the database**, were made intentionally to showcase technical skills, even though this is not the recommended practice for production.  

---

## 👨‍💻 Author  

Developed by **Jamerson Macedo** ✨
