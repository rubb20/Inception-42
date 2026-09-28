
NAME=Inception

$(NAME): all

all:
	mkdir -p /home/ralba-ji/data/mariadb /home/ralba-ji/data/wordpress
	docker compose -f srcs/docker-compose.yml build

run: all
	docker compose -f srcs/docker-compose.yml up --wait

down:
	docker compose -f srcs/docker-compose.yml down

clean:
	docker system prune -f

fclean: down clean
	sudo rm -rf /home/ralba-ji/data

re: fclean all

.PHONY: all run down clean fclean re
