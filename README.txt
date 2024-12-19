Projeto ibbc Vítor Medeiros 56351

Para correr este conjunto de scripts é neceesáriocolocar os ficheiros fastq de pair end reads na
pasta raw_data que esta no diretorio projectIbbc.

Run script1.sh -> vai criar a diretoria data_analysis que ira conter todos os ficheiros de output do:
FastQC, Fastp e GetOrgannelles. Ira, tanbem mover os ficheiros que foram colocados na pasta project/raw_data 
para a diretoria data_analysis para poderem ser processados..

Run script2.sh -> vai analisar, filtar e produzir os relatorios das ferramentas FastQC, Fastp e GetOrgannelles.
no fim de correr os ficheiros estarao organizados desta forma: 

data_analysis/
├── raw_data/
│   ├── #Ficheiros fastq dados pelo utilizador antes de correr o script1.sh                 
├── qc_reports/
│   ├── #Relatorios gerados pelo FastQC e Fastp                
├── processed_data/           
│   ├──#Arquivos FASTQ processados pelo Fastp
├── results/                  
|   |   # Resultados finais gerados pelo GetOrganelle
│   ├── Sample1_getorganelle_output/
│   │   
│   ├── Sample2_getorganelle_output/
│  
├── logs/                     
│   ├── #logs de execucao para cada etapa da pipeline

Certifique-se que guarda os relatorios e os ficheiros produzidos que sao necessarios guardar.

Run script3.sh -> vai eliminar toda a diretoria data_analysis e volta a colocar os ficheiros fastq
inicialmaente dados pelo utilizador na diretoria projectIbbc/raw_data. 

CUIDADOS ADICIONAIS:
Os paths dos diretorios a ser usados devem ser certficados e corrigidos antes de correr os scripts
