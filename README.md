# Special Measure
## Instruções de uso
**Obs: Sempre rode os arquivos a partir da pasta onde eles se localizam**
### Rodar o programa
Para usar em um computador que já tenha o rack configurado corretamente (arquivo `rack.mat` existe), basta abrir o arquivo `run.m` no matlab e roda-lo. (Confira se a pasta Library está inclusa no path, com todas as subpastas)
### Configurar um rack
O arquivo `generate_instruments.m` cria uma cópia de instrumentos inclusos na pasta Library/instruments, porém adicionando um constructor para comunicação via VISA, com o endereço especificado no constructor.args.
Esse arquivo deve ser executado para gerar as cópias locais dos `smint_INSTRUMENT.mat`
Após gerar os instrumentos, basta rodar o `configure_rack.m` para gerar o arquivo base do rack com aqueles instrumentos.

Normalmente esse procedimento envolvendo gerar os instrumentos e o rack só precisará ser feito ao adicionar um instrumento novo, ou se por algum motivo as portas GPIB mudarem.

---

Cópia do código original do SpecialMeasure disponível na branch [original](https://github.com/LabNano/special-measure/tree/original).
