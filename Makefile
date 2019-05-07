meta:
	@jq -L. -n '"jsonpointer"|modulemeta'

test:
	@./tests/run.sh || true
