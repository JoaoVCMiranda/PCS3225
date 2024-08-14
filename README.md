# PCS3225

Conhecimentos ocultos e aleatórios para os projetos de SD2.

---

Prof. Marco

---

## Livros
-   [free range vhdl](https://github.com/fabriziotappero/Free-Range-VHDL-book)

## Projeto Zero

Multiplicador

![Ondas!](MultiplicadorBinário/Ondas.png)

## Quartus
Outra via para fazer simulações e também serve para gravar na FPGA
[Intel Quartus](https://www.intel.com/content/www/us/en/products/details/fpga/development-tools/quartus-prime.html)

## Atividade de Fixação 1

Para fazer a leitura do arquivo externo `multiplicador_tb.dat`, nós

- Colocamos os componentes do multiplicador numa pasta
- Importamos ∫'mente a biblioteca `std.textio`
- Vinculamos a leitura do arquivo ao começo do process
- Transformamos os textos em sinais internos
- Atribuimos o sinais às entradas do `multiplicador.vhd`
- Comparamos a saida com a terceira coluna do arquivo `.dat`

