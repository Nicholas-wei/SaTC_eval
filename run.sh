cd /home/satc/SaTC
./init.sh
mkdir -p /home/satc/res/
python ./satc.py -d ./firmware/R6400-V1.0.1.24_1.0.18/_R6400-V1.0.1.24_1.0.18.chk.extracted/squashfs-root/ -o /home/satc/res/R6400-V1.0.1.24_1.0.18 -b httpd --ghidra_script=ref2sink_cmdi --ghidra_script=ref2sink_bof --taint_check
python ./satc.py -d ./firmware/FW_EA9200_1.1.9.183676_prod/_FW_EA9200_1.1.9.183676_prod.img.extracted/ -o /home/satc/res/FW_EA9200_1.1.9.183676 --ghidra_script=ref2sink_cmdi --ghidra_script=ref2sink_bof --taint_check
python ./satc.py -d ./firmware/DIR-604M_v1.10KRb08/_DIR-604M_v1.10KRb08.trx.extracted -o /home/satc/res/_DIR-604M_v1.10KRb08.trx --ghidra_script=ref2sink_cmdi --ghidra_script=ref2sink_bof --taint_check
python ./satc.py -d ./firmware/FW_WL_330N3G_1035/_FW_WL_330N3G_1035.trx.extracted/_40.extracted/_375000.extracted/cpio-root/ -o /home/satc/res/FW_WL_330N3G_1035 --ghidra_script=ref2sink_cmdi --ghidra_script=ref2sink_bof --taint_check
python ./satc.py -d ./firmware/DIR868LWB1_FW200KR-K01/_DIR868LWB1_FW200KR-K01.bin.extracted/squashfs-root/ -o  /home/satc/res/DIR868LWB1_FW200KR-K01 --ghidra_script=ref2sink_cmdi --ghidra_script=ref2sink_bof --taint_check
python ./satc.py -d ./firmware/FW_RT_N10D1_211192/_RT-N10D1_2.1.1.1.92.trx.extracted/squashfs-root -o /home/satc/res/FW_RT_N10D1_211192 --ghidra_script=ref2sink_cmdi --ghidra_script=ref2sink_bof --taint_check
