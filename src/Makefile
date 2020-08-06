all: clean
	zilf -w heartice.zil
	-zapf -ab heartice.zap > heartice_freq.xzap
	rm heartice_freq.zap
	zapf heartice.zap

test: clean
	zilf -w heartice.zil
	zapf heartice.zap
	
clean:
	rm -f *.xzap *.zap *.z?
