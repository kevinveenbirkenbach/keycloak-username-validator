IMAGE_NAME     := keycloak-username-validator-builder
OUTPUT_DIR     := output
JAR_NAME       := username-validator.jar
TARGET_JAR     := username-validator-1.0.0.jar  # actual filename in target/
CONTAINER_NAME := $(IMAGE_NAME)-tmp

.PHONY: all build extract clean

all: build extract

build:
	docker build -t $(IMAGE_NAME) .

extract:
	@mkdir -p $(OUTPUT_DIR)
	# 1) Create a stopped container from the image
	docker create --name $(CONTAINER_NAME) $(IMAGE_NAME) >/dev/null
	# 2) Copy the built JAR out of /app/target/ in that container
	docker cp $(CONTAINER_NAME):/output/$(JAR_NAME) $(OUTPUT_DIR)/$(JAR_NAME)
	# 3) Remove the temporary container
	docker rm $(CONTAINER_NAME) >/dev/null
	@echo "→ Extracted $(JAR_NAME) to $(OUTPUT_DIR)/"

clean:
	rm -rf $(OUTPUT_DIR)
	docker rmi $(IMAGE_NAME) || true
