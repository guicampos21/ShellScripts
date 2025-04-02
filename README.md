O intuito deste script é rodar um MTR continuamente e guardar os logs disso, algo que é útil quando você tem um problema intermitente. 

Como utilizar o script

Baixe-o [**AQUI**](https://github.com/guicampos21/ShellScripts/blob/main/mtrlog.sh)

Instale o MTR na sua máquina ou servidor;
- Debian/Ubuntu e derivados: `apt update && apt install mtr -y`
- RHEL/OL/Rocky/CENTOS: `yum install mtr -y`

Dica: Caso precise executar o script por longos períodos de tempo, utilize o **TMUX**, entenda como ele funciona clicando [**AQUI**](https://www.hostinger.com.br/tutoriais/como-usar-tmux)

Ao rodar o script ele solicitará:
- Destino a ser testado (IP ou FQDN);
- Quantos pacotes serão enviados em cada ciclo de teste;
- Intervalo entre cada ciclo de teste.

Entenda um ciclo de teste como uma execução do MTR, sendo assim, o intervalo entre as execuções nunca deverá ser menor ou muito próximo do número de pacotes.

Os logs ficam no diretório **logmtr**, criado no diretório onde está o script.
