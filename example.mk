include build/easybake.mk

include $(MODULE)
module=test
srcs=test.cpp

include $(MODULE)

test:
	@echo $(TOP)