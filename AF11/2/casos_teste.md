Esse registrador depende do parâmetro wordSize, 

Se esse parâmetro for omitido o arquivo `reg.vhdl` deve funcionar como um registrador de tamanho de palavra 4.

Assim, os casos testes sugeridos são:

# Registrador (`reg.vhdl`)

- Leitura antes de escrever qualquer coisa(não sei oq acontece)
- Escrever valores e depois tentar lê-los

```plaintext
0000
0001
0010
0100
1000
1111
```
> Fazer os casos generalizados para palavras de 64 bits

Para escrever colocar esses valores na entrada "d", definir enable='1' e esperar um ciclo de clock.

Para ler é assíncrono, então pode ser feito logo em seguida.

---

Para testar a parametrização, usar o `map generic(8)` antes do `port map(...)`, provavelmente sem `";"`.

e os casos de teste sugeridos são:

```plaintext
00000000
00000001
00000010
00000100
00001000
00010000
00100000
01000000
10000000
11111111
```

# Banco de Registradores (`regfile.vhdl`)

- Escrita em um registrador por vez
    - regWrite
    - wr
- Zerar o banco
    - reset
- Popular o regfile
    - d
    - wr
- Fazer leituras simultaneas
    > duas leituras ao mesmo tempo
    - com base no que for populado
    - fazer a leitura de 2 em 2
