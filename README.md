# URLShortener

Example project created to test the combination of concepts applied in Swift technology.

##  Capturas de tela do aplicativo

<img src="Imagens/Foto 1.png" width="200" height="395"><img src="Imagens/Foto 2.png" width="200" height="395"><img src="Imagens/Foto 3.png" width="200" height="395"><img src="Imagens/Foto 4.png" width="200" height="395"><img src="Imagens/Foto 5.png" width="200" height="395"><img src="Imagens/Foto 6.png" width="200" height="395"><img src="Imagens/Foto 7.png" width="200" height="395"><img src="Imagens/Foto 8.png" width="200" height="395">

##  Demonstração de uso

https://github.com/user-attachments/assets/559a1e77-f262-41e3-8d6d-79c15ac498c6

##  Base Arquitetural

O projeto utiliza MVVM-C como base arquitetural:

M – Model (entidades, respostas de rede, modelos de domínio)

V – View (SwiftUI Views)

VM – ViewModel (regras de apresentação, orquestração de casos de uso)

C – Coordinator (camada responsável pela navegação e fluxo entre telas)

##  Camadas da Arquitetura

## UseCases (Camada de Domínio / Serviços)

Representam casos de uso da aplicação (ex.: encurtar URL, recuperar URL original).

São responsáveis por orquestrar chamadas externas:
APIs HTTP (via NetworkOperation);
Futuramente outros serviços (banco local, cache, etc.).

Exemplo:
CreateShortenURLUseCase
RecoverShortenURLUseCase

## ViewModel

Camada que conhece os UseCases e concentra a lógica de apresentação.

Responsabilidades:
Invocar UseCases (ex.: criar URL encurtada, recuperar URL original).
Transformar Responses em modelos adequados pra interface:
Controle de estados (isLoading, lista vazia, erro, etc.).
Expor estado para a View via @Published.

Exemplo:
HomeViewModel
DetailViewModel

## View (SwiftUI)

Camada com responsabilidade exclusiva de layout e estados de tela.

Observa a ViewModel via @StateObject e re-renderiza conforme o estado muda.
Não contém regras de negócio nem lógica de acesso à rede.

Exemplos:
HomeView
DetailView

## Coordinator (C de MVVM-C / Navegação)

A responsabilidade do Coordinator é orquestrar navegação e fluxo entre cenas.

No projeto, essa função é exercida pela camada Navigation, em especial:

NavigationCoordinator

Enum(s) de rota, se existentes (ex.: AppRoute, HomeRoute, etc.).

A View não decide “como” navegar, apenas pede:

Ex.: coordinator.showDetail(alias: item.title) na HomeView.

## Testabilidade:

UseCases podem ser testados isoladamente com mocks de NetworkOperationProtocol.

ViewModels podem ser testadas usando mocks de UseCases.

Views podem ser validadas visualmente com snapshots.
