<img src="./docs/cornerstone.png" width="100%">

Cornerstone é um blueprint arquitetônico para repositórios de software que estabelece fundamentos estruturais, operacionais e culturais para projetos duráveis.

Ele define princípios claros de organização, interface unificada via Makefile, documentação viva e contratos de colaboração independentes de stack ou linguagem. Mais que um template, Cornerstone é um ponto de alinhamento: a pedra angular que orienta estrutura, governança e evolução de qualquer projeto.

Adotar o Cornerstone significa substituir improviso por fundação, acoplamento por clareza e conhecimento implícito por estrutura explícita.

---

Este projeto define um boilerplate universal para repositórios, focado em padronização, clareza estrutural e automação.
Propõe uma interface unificada via Makefile, independente de stack ou linguagem.
Estabelece convenções para documentação, versionamento e CI/CD.
Transforma código em ativo sustentável, reduzindo fricção e dependência de conhecimento implícito.

> Mais que um template, é um contrato operacional para projetos duráveis.
>
> O boilerplate não impõe linguagem. **Ele impõe ritual.**



# Primeiros passos

Se você está criando um novo projeto utilize o seguinte comando:
```bash
λ create "my new project" with makefile.only git.{hook,init} readme.only
```

De forma estruturada podemos dizer que
```bash
read -r project_name
        # É o nome do projeto a ser criado.
        # Será o diretório e repositório onde seu projeto será salvo no
        # perfil designado desde que previamente configurado (via `λ init`).
        # Atenção: nomes com espaçamentos ou caracteres diferentes de a-z, 0-9,
        # \- e _ serão substituídos quando possível.
        # Veja mais detalhes na documentação.

λ create "${project_name}"  \
    with {git.{hook,init},{makefile,readme},ion.node}
        # Define o nome, diretório e repositório.
        # Adiciona recursos ao seu repositório.
        # Inicializa o repositório com hooks.
        # Adiciona Makefile e README.md do boilerplate.
        # Adiciona Dockerfile e hooks de orquestração no Makefile.
```

Podendo também ser adicionado via `λ` em projetos existentes:
```bash
λ add {makefile,readme,ion.compose.{nginx,mariadb,node}}
        # Adiciona Makefile e README.md do boilerplate.
        # Adiciona estrutura do íON com Docker Compose.
        # Adiciona serviço proxy nginx.
        # Adiciona serviço de banco de dados MariaDB.
        # Adiciona serviço do NodeJS.
```

> Atenção: a ordem de adição influencia diretamente na ordem de execução dos scripts de instalação dos mesmos.

Gerar a seguinte estrutura:

## Estrutura base de diretórios

O foco é manter a raíz do repositório limpa, sem arquivos ou diretórios desnecessários.

```c
.
├── README.md           // Documentação principal.
|                       // Primeiro contato com o projeto.
|
├── docs/               // Documentação adicional do projeto.
|                       // Possivelmente gerada por `make doc`.
|
├── scripts/            // Scripts de instrumentos de manutenção para
|                       // configuração, automatização de taredas, etc.
|
├── src/                // Diretório principal do projeto, onde o código
|                       // fonte está.
|
├── build/              // Diretório geralmente de uso local, contendo
|                       // artefato ou código binário, distribuível, seja ele
|                       // compilado ou não pelo comando `make build`.
|                       // Geralmente esse diretório está no .gitignore e não
|                       // será versionado.
|
├── test/               // Sugestão de suíte de testes - apesar de haverem
|                       // frameworks que implementam os testes dentro do
|                       // diretório da própria aplicação, testes de aceitação
|                       // ou integração tendem a possuir estrutura dedicada.
|
├── .github/            // Configurações de esteiras que executarão através
│   └── workflows/      // das actions do próprio versionador, como o Github
│         └── …         // actions, nesse caso.
|
├── .git/               // Gerenciador do repositório.
│   └── hooks/          // Scripts de automação, coding quality, etc…
│         └── …         // actions, nesse caso.
|
├── Makefile            // Recurso facilitador para executar atividades de
|                       // automatização, governança, e manutenção tanto do
|                       // repositório quanto do projeto.
|
├── CONTRIBUTING.md     // Arquivos de definições padrões para projetos como
├── CODE_OF_CONDUCT.md  // instruções para contribuições, código de conduta e
├── LICENSE             // licença.
|
├── CHANGELOG.md        // Compilado da linha do tempo do projeto, com
|                       // informações sobre a versão atual e histórico para
|                       // entendimento humano, podendo ser gerado
|                       // automaticamente via `make changelog` por exemplo.
|
├── .editorconfig       // Estipula os padrões de projeto para os arquivos
|                       // utilizados pela aplicação - como indentação, padrões
|                       // de fim de linha, tabela de caracteres, etc.
|
├── .gitignore          // Estipula quais arquivos não deverão ser versionados.
|
└── .λ                  // Diretório de controle do λ::lambda
    ├── scripts/        // Scripts de automação, coding quality, integração,
    │     └── …         // governança, actions, e utilitários.
    └── config.json     // Arquivo de configuração λ::lambda do repositório.
…
```

Ou seja, este repositório tem o intuito de servir de plataforma organizacional para `λ`, `íON` e todo e quaisquer projeto que possa ser implementado, com a finalidade de:
- [x] documentar;
- [x] versionar;
- [x] executar;
- [x] testar;
- [x] contribuir;
- [x] publicar;
- [x] integrar;

A stack muda. O esqueleto não.



### 📖 README.md

Não é só descrição do projeto. É propósito.

É o quick start, exemplos de uso, decisões arquiteturais resumidas, status do projeto (que podem ser resumidos com o uso de badges, shields, etc). Ele é a porta de entrada, o primeiro contato com o projeto e o ideal é que possua informação o suficiente para **direcionar o usuário nos seus primeiros passos.**



### 📚 docs/

Documentação viva e modular.

Mantém arquivos com definições da arquitetura, decisões técnicas (ADR), roadmap, histórico de migração. Se for mais complexo, pode usar: MkDocs, PHPDocs, Docusaurus, Wikipages ou markdown simples mesmo.

Aqui a documentação provém tanto do código fonte, obtida através de geradores, compilando a análise da aplicação em Markdown e/ou a ferramenta que convir, lembrando que o imprescindível é que o código esteja devidamente comentado, utilizando clean code e clean architeture, assim como o repositório mantido organizado e limpo, com commits e pull requests devidamente redigidos e revisados.



### 🔧 scripts/

Scripts auxiliares independentes da stack como:
- setup.sh;
- bootstrap;
- migrations;
- validações;
- helpers;

Aqui mora a automação que não cabe no `Makefile` - ou que o Makefile executará de forma automatizada e organizada - e que também não faz parte do projeto em si. São ferramentas que serão executadas em ambientes e/ou condições específicas, conforme documentação.



### ⚙️ Makefile

Um Makefile é um arquivo de texto especializado utilizado pelo utilitário de automação make, que define uma série de regras, targets, e dependências usadas na construção de projetos de software. O Makefile é usado para automatizar tarefas repetitivas, como compilar código-fonte, fazer uma linkedição de bibliotecas, e remover arquivos temporários, garantindo que apenas os objetos modificados sejam recompilados, facilitando o gerenciamento de projetos complexos por meio de comandos simples.

Normalmente - mas não exclusivamente - sendo:

Comando| Descrição
-------|-----------
help   | Exibe os comandos válidos do Makefile.
install| Instala os requisitos e executa os scripts necessários para a execução do projeto.
build  | Executa o processo de montagem do artefato.
deploy | Executa processos de validação, testes e montagem do artefato.
test   | Realiza testes.
lint   | Realiza validação dos arquivos.
run    | Executa a aplicação.
clean  | EDeleta arquivos temporários ou gerados automaticamente.

Mesmo que internamente chamem comandos ou executores como o `npm`, `go`, `docker`, etc. Os desenvolvedores e devops envolvidos só tem a real necessidade de aprender e executar comandos como `make build`, `make test`, `make run` tornando o Makefile em "linguagem comum" entre os times.

### Versionamento semântico e Gitflow

A utilização do Gitflow na prática tem inúmeras vantagens, principalmente para a programação de software, onde podem existir múltiplas funcionalidades, correções, e lançamentos ao **mesmo tempo**, sem quebrar o código em produção.

O Gitflow é uma estratégia de ramificação baseada no Git, com uma estrutura clara para a equipe, tornando a colaboração mais eficiente.

Os principais motivos para a utilização do Gitflow na prática são os seguintes:
Isolamento de Funcionalidades (Feature Branches): Cada funcionalidade desenvolvida pelo programador será implementada em uma branch (ramificação), a partir da develop. Isso permite que colegas trabalhem em paralelo sem interferir nos trabalhos dos outros programadores.

Produção Estável (Main/Master Branch): A main (ou master) branch possui apenas códigos estáveis e prontos para a produção. O Gitflow garante que o código não seja enviado para a produção, mantendo a estabilidade.
Gerenciamento de Releases (Release Branches): O Gitflow facilita a preparação de releases. Uma branch de releases permite à equipe concluir, testar, e corrigir bugs de uma versão específica, ao mesmo tempo em que a develop branch continua com a implementação de novas funcionalidades para a próxima versão.

Isso funciona para qualquer stack e facilita muito utilizar prefixos nas branches como `feat`, `fix`, `docs`, `refactor`, `chore`, ou o que for convencionado com o time.

Exemplo de linha de commits:

```bash
*   a9f3c21 (HEAD -> develop) Merge branch 'feat/pagamentos'
|\  
| * 7c2ab11 (feat/pagamentos) Integra gateway Stripe 2 hours ago John
| * 4f91e88 Adiciona validação de cartão 3 hours ago John
| * b12de44 Estrutura inicial do módulo de pagamentos 5 hours ago John
* |   8dd4e90 Merge branch 'release/1.1.0'
|\ \  
| |/  
|/|   
| *   3ac91ff (release/1.1.0) Ajusta versão para 1.1.0 1 day ago Mariana
| *   e91bd72 Merge branch 'hotfix/login-fix'
| |\  
| | * f54aa21 (hotfix/login-fix) Corrige bug crítico no login 1 day ago Mariana
| |/  
| * 1c88a7e Atualiza changelog 2 days ago Mariana
|/  
*   5ab21c4 Merge branch 'feat/dashboard'
|\  
| * 99bc812 (feat/dashboard) Implementa gráfico de vendas 3 days ago Paula
| * 1aa77f0 Cria layout inicial do dashboard 4 days ago Paula
|/  
* 42fbc19 (main) Release 1.0.0 1 week ago John
* 8c11d9e Setup inicial do projeto 2 weeks ago John
```

CHANGELOG padronizado

📜 🏗️ 📘 🧩 🌱 🤝 🧠 🧼 🔐 ⚙️
