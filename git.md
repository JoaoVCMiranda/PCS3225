# Git para PCS3225

## Instalação

Fazer a instalação padrão do [git](https://git-scm.com/downloads)

ou

```
	sudo apt install git
```

Depois que o git estiver instalado, 
abrir no menu iniciar > git bash GUI

### Gerar chave

Gerar a chave ssh para autenticar o seu computador no github 

```
ssh-keygen -t ed25519
```

### Vincular chave

No github > Conta > SSH and GPG keys

No computador > [Pasta_raiz]/.ssh/[nome_da_sua_chave].pub

### Clonar o repositório

### Separar o trabalho em branches

```
git checkout -b [nome_da_sua_branch]
```

### Utilização com vscode

```
git pull
git add *
git add -u
git commit -m "sua msg"
git push
```


### Instalar as extensões
donjayamanne.git-extension-pack
puorc.awesome-vhdl

### Configurar o usuário global

```
git config --global user.name "seu nome"
git config --global user.email "seu email"
```


