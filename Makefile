
NAME=Inception

$(NAME): all

all:
	mkdir -p /home/$(USER)/data/mariadb /home/$(USER)/data/wordpress
	docker compose -f srcs/docker-compose.yml build wordpress mariadb nginx

bonus:
	mkdir -p /home/$(USER)/data/mariadb /home/$(USER)/data/wordpress
	docker compose -f srcs/docker-compose.yml build

run: all
	docker compose -f srcs/docker-compose.yml up --no-deps --no-build --wait wordpress mariadb nginx

run-bonus: bonus
	docker compose -f srcs/docker-compose.yml up --no-build --wait 

start:
	docker compose -f srcs/docker-compose.yml start

stop:
	docker compose -f srcs/docker-compose.yml stop

down:
	docker compose -f srcs/docker-compose.yml down

clean:
	docker system prune -a -f

fclean: down
	docker system prune -a -f --volumes
	sudo rm -rf /home/$(USER)/data

re: fclean all

.PHONY: $(NAME) all bonus down clean fclean re
