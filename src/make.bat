@echo off
del *.xzap *.zap *.z?
zilf -w heartice.zil
zapf -ab heartice.zap > heartice_freq.xzap
del heartice_freq.zap
zapf heartice.zap
