.SILENT:


all:
	@echo hello world!

clean:
	del WDI_csv.zip WDICountry.csv

WDI_csv.zip :
	curl https://databankfiles.worldbank.org/data/download/WDI_csv.zip --output $(@)

WDICountry.csv: WDI_csv.zip
	7z x WDI_csv.zip $(@)
