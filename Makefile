.PHONY: install_jupyter_kernel jupyter

#GLOBALS
PROJECT_NAME = dev_spark
PYTHON_INTERPRETER = python3

# TARGETS
install_jupyter_kernel:
	docker compose exec dev $(PYTHON_INTERPRETER) -m ipykernel install --user --name jupyter_$(PROJECT_NAME) --display-name "kernel_$(PROJECT_NAME)"

run_jupyter:
	docker compose exec dev jupyter notebook --ip 0.0.0.0 --port 8888 --no-browser --allow-root --NotebookApp.token='password'