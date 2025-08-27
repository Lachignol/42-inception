NAME = Inception

all: create_dirs build up

build:
	docker compose -f srcs/docker-compose.yml build

up:
	docker compose -f srcs/docker-compose.yml up -d

down:
	docker compose -f srcs/docker-compose.yml down

create_dirs:
	mkdir -p /home/${SUDO_USER}/data/mariadb
	mkdir -p /home/${SUDO_USER}/data/wordpress
	mkdir -p /home/${SUDO_USER}/data/backup

clean: down
	docker system prune -a -f --volumes > /dev/null 2>&1

remove_dir:
	rm -rf /home/${SUDO_USER}/data

fclean: down clean remove_dir

re: fclean all

.PHONY: all build up down clean remove_dir create_dirs fclean re

