#
# λ::Makefile
#

TODAY  ?= $(shell date +'%Y%m%d%H%M%S')
WARNING = Automatically generated on $(TODAY)

ifneq (,$(DESTDIR))
TARGET =$(DESTDIR)
else
TARGET = .
endif

SOURCE= source_file_or_folder
RULES = rule  \
	set   \
	about \
	your  \
	project

FILES = $(RULES) \
	$(SOURCE)

AVAILABLE_COMMANDS = \
	build \
	lint \
	fix \
	dev \
	start

 BOLD = \e[1m
/BOLD = \e[0m

.DEFAULT_GOAL := help
 DEFAULT      :  help
# For further information see `README.md`.
#

# Repository maintenance options:
#
install:	# Installs application.
	@\
	echo "Installing application…"

available:	# Show available commands.
	@\
	echo "$(AVAILABLE_COMMANDS)"

clean:	# Clean generated, temporary and working folders.
	@\
	echo "Cleaning generated folders…"

#
run-%:	# Perform command targeting a wildcard.
	@\
	wildcard="$(*)"; \
	echo "Do something with $(BOLD)$${wildcard}$(/BOLD)"

#
help: # Shows this help.
	@\
	_='s/(`.*`)/$(BOLD)\1$(/BOLD)/'; \
	fix() { sed --posix "$${_}" ; }; \
	echo """"""""""""""""""""""""""" \
	$$(awk 'BEGIN {  FS=":.*?#"""  } \
	/^(\S+:.*|)#/ {                  \
	S = "\\e[0;0;2;3;m%s\\e[0;m""" ; \
	C = "\t\\e[0;1m%-10s\\e[0;m%s" ; \
	gsub( "^( : |)#( |)", """"""""); \
	N = length($$2); T = (N<1?S:C ); \
	printf(T"""\n""""", $$1, $$2 ); \
	}' $(MAKEFILE_LIST) |  fix )"

#
%:
	@:
