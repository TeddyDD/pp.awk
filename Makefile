MAN_PAGES = pp.awk.1

ifeq ($(PREFIX),)
	PREFIX := /usr/local
endif

install: man
	install pp.awk $(DESTDIR)$(PREFIX)/bin/
	install -m 644 pp.awk.1 $(DESTDIR)$(PREFIX)/man/man1/

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/pp.awk
	rm -f $(DESTDIR)$(PREFIX)/man/pp.awk.1

man: $(MAN_PAGES)

%.1: %.1.scd
	scdoc < $< > $@
