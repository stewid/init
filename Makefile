DOWNLOADS=~/Downloads
EMACS_VER=24.5

EMACS_EXISTS=YES
ifeq (, $(shell which emacs))
EMACS_EXISTS=NO
endif

GIT_EXISTS=YES
ifeq (, $(shell which git))
GIT_EXISTS=NO
endif

R_EXISTS=YES
ifeq (, $(shell which R))
R_EXISTS=NO
endif

RD_EXISTS=YES
ifeq (, $(shell which RD))
RD_EXISTS=NO
endif

all: emacs git R R-devel

emacs:
	@if [ "$(EMACS_EXISTS)" = "NO" ]; then \
	    sudo apt-get build-dep emacs24; \
	    cd $(DOWNLOADS) && wget https://ftp.gnu.org/pub/gnu/emacs/emacs-$(EMACS_VER).tar.gz; \
	    cd $(DOWNLOADS) && tar zxvf emacs-$(EMACS_VER).tar.gz; \
	    cd $(DOWNLOADS)/emacs-$(EMACS_VER) && ./configure; \
	    cd $(DOWNLOADS)/emacs-$(EMACS_VER) && make; \
	    cd $(DOWNLOADS)/emacs-$(EMACS_VER) && sudo make install; \
	    rm -rf $(DOWNLOADS)/emacs-$(EMACS_VER); \
	    rm $(DOWNLOADS)/emacs-$(EMACS_VER).tar.gz; \
	    sudo sh -c 'echo "[Desktop Entry]" > /usr/share/applications/emacs.desktop'; \
	    sudo sh -c 'echo "Version=$(EMACS_VER)" >> /usr/share/applications/emacs.desktop'; \
	    sudo sh -c 'echo "Name=Emacs" >> /usr/share/applications/emacs.desktop'; \
	    sudo sh -c 'echo "Exec=env UBUNTU_MENUPROXY=0 /usr/local/bin/emacs" >> /usr/share/applications/emacs.desktop'; \
	    sudo sh -c 'echo "Terminal=false" >> /usr/share/applications/emacs.desktop'; \
	    sudo sh -c 'echo "Icon=emacs" >> /usr/share/applications/emacs.desktop'; \
	    sudo sh -c 'echo "Type=Application" >> /usr/share/applications/emacs.desktop'; \
	    sudo sh -c 'echo "Categories=IDE" >> /usr/share/applications/emacs.desktop'; \
	    sudo sh -c 'echo "X-Ayatana-Desktop-Shortcuts=NewWindow" >> /usr/share/applications/emacs.desktop'; \
	    sudo sh -c 'echo "[NewWindow Shortcut Group]" >> /usr/share/applications/emacs.desktop'; \
	    sudo sh -c 'echo "Name=New Window" >> /usr/share/applications/emacs.desktop'; \
	    sudo sh -c 'echo "TargetEnvironment=Unity" >> /usr/share/applications/emacs.desktop'; \
	fi

git:
	@if [ "$(GIT_EXISTS)" = "NO" ]; then \
	    sudo apt-get install git; \
	    git config --global user.name "Stefan Widgren"; \
	    git config --global user.email stefan.widgren@gmail.com; \
	fi

R:
	@if [ "$(R_EXISTS)" = "NO" ]; then \
	    sudo add-apt-repository "deb https://cran.rstudio.com/bin/linux/ubuntu trusty/"; \
	    sudo add-apt-repository "deb http://se.archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe"; \
	    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9; \
	    sudo apt-get update; \
	    sudo apt-get -y build-dep r-base; \
	    sudo apt-get -y install r-base rbase-dev; \
	fi

R-devel:
	@if [ "$(RD_EXISTS)" = "NO" ]; then \
	    cd $(DOWNLOADS) && wget https://stat.ethz.ch/R/daily/R-devel.tar.gz; \
	    cd $(DOWNLOADS) && tar zxvf R-devel.tar.gz; \
	    cd $(DOWNLOADS)/R-devel && ./configure --prefix=/usr/local/R/R-devel; \
	    cd $(DOWNLOADS)/R-devel && make; \
	    cd $(DOWNLOADS)/R-devel && sudo make install; \
	    sudo ln -s /usr/local/R/R-devel/bin/R /usr/bin/RD; \
	    rm -rf $(DOWNLOADS)/R-devel; \
	    rm $(DOWNLOADS)/R-devel.tar.gz; \
	fi

.PHONY: all emacs git R R-devel
