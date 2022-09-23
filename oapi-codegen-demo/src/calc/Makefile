api.gen.go: api.yml config.yml
	oapi-codegen --config=config.yml api.yml > api.gen.go || rm -f api.gen.go

clean:
	rm -f api.gen.go
