# SaTC

A prototype of Shared-keywords aware Taint Checking(SaTC), a static analysis method that tracks user input between front-end and back-end for vulnerability discovery effectively and efficiently. 

## experiment for Program Analysis
1. download firmware dataset

```shell script
# get dataset firmware.zip, which contains the firmware mentioned in the paper
# The image is very large, about 1.3GB. So it cannot be uploaded to github. You need to downloada it from web broswer
https://web.ugreen.cloud/web/#/share/HB-nkqC549HH332ilYD-20FA7A 提取码：NYK3
```

2. unzip dataset

```shell script
# unzip dataset
# notice: there is no unzip in the SaTC docker, you have to unzip in host environment and map it into docker
unzip ./firmware.zip -d ./firmware
```

3. download satc docker

```shell script
# Get image from Docker hub 
docker pull smile0304/satc

# Run SaTC (Need to add mapping directory by yourself)
docker run -v ./firmware:/firmware -it smile0304/satc
```
4. run experiment
you can run the following shell script inside docker, or download `run.sh` from this repo and execute `./run.sh` inside docker
```shell script
cd /home/satc/SaTC
./init.sh
mkdir -p /home/satc/res/
# run SaTC for firmware _R6400-V1.0.1.24_1.0.18
mkdir -p /home/satc/res/_R6400-V1.0.1.24_1.0.18
python ./satc.py -d /firmware/R6400-V1.0.1.24_1.0.18/_R6400-V1.0.1.24_1.0.18.chk.extracted/squashfs-root/ -o /home/satc/res/R6400-V1.0.1.24_1.0.18 -b httpd --ghidra_script=ref2sink_cmdi --ghidra_script=ref2sink_bof --taint_check

# run satc for firmware _FW_EA9200_1.1.9.183676_prod
mkdir -p /home/satc/res/FW_EA9200_1.1.9.183676
python ./satc.py -d /firmware/FW_EA9200_1.1.9.183676_prod/_FW_EA9200_1.1.9.183676_prod.img.extracted/ -o /home/satc/res/FW_EA9200_1.1.9.183676 --ghidra_script=ref2sink_cmdi --ghidra_script=ref2sink_bof --taint_check

# run satc for firmware DIR-604M_v1.10KRb08
mkdir -p /home/satc/res/_DIR-604M_v1.10KRb08.trx
python ./satc.py -d /firmware/DIR-604M_v1.10KRb08/_DIR-604M_v1.10KRb08.trx.extracted -o /home/satc/res/_DIR-604M_v1.10KRb08.trx --ghidra_script=ref2sink_cmdi --ghidra_script=ref2sink_bof --taint_check

# run satc for firmware FW_WL_330N3G_1035
# mkdir -p /home/satc/res/FW_WL_330N3G_1035
python ./satc.py -d /firmware/FW_WL_330N3G_1035/_FW_WL_330N3G_1035.trx.extracted/_40.extracted/_375000.extracted/cpio-root/ -o /home/satc/res/FW_WL_330N3G_1035 --ghidra_script=ref2sink_cmdi --ghidra_script=ref2sink_bof --taint_check

# run satc for firmware DIR868LWB1_FW200KR-K01
mkdir -p /home/satc/res/DIR868LWB1_FW200KR-K01
python ./satc.py -d /firmware/DIR868LWB1_FW200KR-K01/_DIR868LWB1_FW200KR-K01.bin.extracted/squashfs-root/ -o  /home/satc/res/DIR868LWB1_FW200KR-K01 --ghidra_script=ref2sink_cmdi --ghidra_script=ref2sink_bof --taint_check

# run satc for firmware FW_RT_N10D1_211192
mkdir -p /home/satc/res/FW_RT_N10D1_211192
python ./satc.py -d /firmware/FW_RT_N10D1_211192/_RT-N10D1_2.1.1.1.92.trx.extracted/squashfs-root -o /home/satc/res/FW_RT_N10D1_211192 --ghidra_script=ref2sink_cmdi --ghidra_script=ref2sink_bof --taint_check
```
## experiment result
The result for the homework is located inside `res/` in this repo. You can also replay the above experiment.

## Output 
Directory structure：

```shell
|-- ghidra_extract_result
|   |-- httpd
|       |-- httpd
|       |-- httpd_ref2sink_bof.result
|       |-- httpd_ref2sink_cmdi.result
|       |-- httpd_ref2sink_cmdi.result-alter2
|-- keyword_extract_result
|   |-- detail
|   |   |-- API_detail.result
|   |   |-- API_remove_detail.result
|   |   |-- api_split.result
|   |   |-- Clustering_result_v2.result
|   |   |-- File_detail.result
|   |   |-- from_bin_add_para.result
|   |   |-- Not_Analysise_JS_File.result
|   |   |-- Prar_detail.result
|   |   |-- Prar_remove_detail.result
|   |-- info.txt
|   |-- simple
|       |-- API_simple.result
|       |-- Prar_simple.result
|-- result-httpd-ref2sink_cmdi-ctW8.txt
```

Need to follow such important directories:

- keyword_extract_result/detail/Clustering_result_v2.result : The match of front-end keywords in bin. Input for the `Input Entry Recognition` module
- ghidra_extract_result/{bin}/* : Analysis result of ghidra script. Input for `Input Sensitive Taint Analysise` module
- result-{bin}-{ghidra_script}-{random}.txt: taint analysis result

Other directories:

```shell
|-- ghidra_extract_result # ghidra looks for the analysis results of the function call path, enabling the `--ghidra_script` option will output the directory
|   |-- httpd # Each bin analyzed will generate a folder with the same name
|       |-- httpd # Bin being analyzed
|       |-- httpd_ref2sink_bof.result # Locate BoF sink function path
|       |-- httpd_ref2sink_cmdi.result # Locate CmdI sink function path
|-- keyword_extract_result  # Keyword extraction results
|   |-- detail  # Front-end keyword extraction results (detailed analysis results)
|   |   |-- API_detail.result # Detailed results of the extracted API
|   |   |-- API_remove_detail.result # API information filtered out
|   |   |-- api_split.result  # Matching API results
|   |   |-- Clustering_result_v2.result # Detailed matching results 
|   |   |-- File_detail.result  # Keywords extracted from each file
|   |   |-- from_bin_add_para.result # Share-keywords generated during binary matching
|   |   |-- Not_Analysise_JS_File.result #Igored JS files by common lib matching
|   |   |-- Prar_detail.result # Detailed results of extracted Prarmeters
|   |   |-- Prar_remove_detail.result # Detailed results of filtered Prarmeters
|   |-- info.txt  # Record processing time and other information
|-- result-httpd-ref2sink_cmdi-ctW8.txt # a typical result file that enable `--taint-check` and `--ghidra_script` options
```

