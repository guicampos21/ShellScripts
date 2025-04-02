#!/bin/bash

# Escrito por Guilherme Campos, Linkedin: https://www.linkedin.com/in/guilherme-campos353/

#Contagem do Ciclo
CICLO=1

# Perguntas ao usuário para definir as variáveis
read -p "Qual o destino que quer testar? " DESTINO
read -p "Quantos pacotes quer enviar em cada ciclo de testes? " CICLOS
read -p "Qual o intervalo em segundos entre cada ciclo de teste? (Nunca menor que Nº de pacotes) " INTERVALO

# Pergunta se deseja resolver nomes
read -p "Você deseja resolver DNS dos saltos até o destino? (1 para Sim, 2 para Não): " RESOLVER_NOMES
if [ "$RESOLVER_NOMES" -eq 2 ]; then
    MTR_OPTS="-n"
else
    MTR_OPTS=""
fi

# Limpa a tela após as perguntas
clear

# Diretório de log
LOG_DIR="$(pwd)/logmtr"

# Arquivo de log
LOG_FILE="$LOG_DIR/mtr_log_$(date +%Y-%m-%d).log"

# Criar diretório de log
mkdir -p $LOG_DIR

# Aviso sobre o arquivo de log
if [ -f "$LOG_FILE" ]; then
    echo "Aviso-1: O arquivo de log atual será deletado na próxima execução."
    rm -f "$LOG_FILE"
fi

# Mensagens de aviso
echo -e "Aviso-2: Caso o teste não seja finalizado, o arquivo de logs seguirá crescendo."
echo -e "Aviso-3: Ao pressionar Enter o script finalizará o ciclo atual antes de encerrar"
echo -e "\nPara cancelar, pressione CTRL + C"
echo -e "\nIniciando teste, por favor aguarde..."
sleep 3
# Função para executar o mtr e registrar packet loss
monitor_mtr() {
  # Adiciona um cabeçalho ao log com a data e hora atuais
  echo "=== $(date '+%Y-%m-%d %H:%M:%S') ===" >> $LOG_FILE

  # Executa o mtr e analisa o resultado
  mtr $MTR_OPTS --report --report-cycles=$CICLOS $DESTINO >> $LOG_FILE 2>&1

  # Adiciona uma linha em branco para separar as entradas no log
  echo "" >> $LOG_FILE
}

# Loop infinito para executar o mtr
while true; do
  monitor_mtr &
#  wait $!
  echo -e "\nCiclo de teste $CICLO iniciado às $(date '+%H:%M:%S'), Pressione ENTER para finalizar..."
  read -r -t 1 input && break
  sleep $INTERVALO
  ((CICLO++))
done

# Exibir resultados e caminho do log
clear

#Limpar última linha com data e hora do arquivo de log
sed -i '$d' $LOG_FILE

cat $LOG_FILE
echo -e "\nCaso precise deste arquivo você pode encontrá-lo em: $LOG_FILE" 
