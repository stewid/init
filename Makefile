DOWNLOADS=~/Downloads
EMACS_VER=24.5
GIT_VER=2.6.2

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

all: emacs git R

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
	    sudo apt-get install libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev; \
	    sudo apt-get install asciidoc xmlto docbook2x; \
	    cd $(DOWNLOADS) && wget https://www.kernel.org/pub/software/scm/git/git-$(GIT_VER).tar.gz; \
	    cd $(DOWNLOADS) && tar zxvf git-$(GIT_VER).tar.gz; \
	    cd $(DOWNLOADS)/git-$(GIT_VER) && make configure; \
	    cd $(DOWNLOADS)/git-$(GIT_VER) && ./configure --prefix=/usr; \
	    cd $(DOWNLOADS)/git-$(GIT_VER) && make all doc info; \
	    cd $(DOWNLOADS)/git-$(GIT_VER) && sudo make install install-doc install-html install-info; \
	    rm -rf $(DOWNLOADS)/git-$(GIT_VER); \
	    rm $(DOWNLOADS)/git-$(GIT_VER).tar.gz; \
	    git config --global user.name "Stefan Widgren"; \
	    git config --global user.email stefan.widgren@gmail.com; \
	fi

R:
	@if [ "$(R_EXISTS)" = "NO" ]; then \
	    sudo add-apt-repository "deb https://cran.rstudio.com/bin/linux/ubuntu wily/"; \
            sudo add-apt-repository "deb http://se.archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe"; \
	    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9; \
	    sudo apt-get update; \
            sudo apt-get build-dep r-base; \
	    sudo apt-get install r-base; \
	    sudo apt-get install r-base-dev; \
	    sudo apt-get install ess; \
	fi

.PHONY: all emacs git R
