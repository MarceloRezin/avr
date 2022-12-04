Projetos de teste que utilizam micro controladores AVR

Device de teste: Attiny 2313a

- Programmer: https://www.fischl.de/usbasp/
- Downloader: https://github.com/avrdudes/avrdude
- Assembler: http://www.avr-asm-tutorial.net/gavrasm/index_en.html

#### Setup:
1. Instalar o AVR Dude: `sudo apt install avrdude`;
2. Instalar o Gavrasm:  
2.1. Baixar o executável;  
2.2. Renomear o binário para "gavrasm";  
2.3. Mover o binário para /opt/gavrasm;  
2.4. Criar o link simbólico: Entrar em /usr/bin e executar `sudo ln -s /opt/gavrasm/gavrasm .`;  
2.5. O assembler deve estar disponível no terminal.  

#### Compilação e download:
No make file é necessário definir o nome do projeto e o MCU com a nomenclatura do AVR Dude.

Disponível no make:
- compile: gera o .hex a partir do fonte.
- flash: Faz o download do hexadecimal no MCU sobrescrevendo a flash.
- all: Executa os 2 passos anteriores de uma só vez

#### Notas:
> O clock vem de fábrica em 8mhz mais o fuse bit `CKDIV8`, resultando em um clock de 1mhz.
