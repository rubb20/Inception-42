NAME=Inception

$(NAME): all

all:
	docker compose -f srcs/docker-compose.yml build

run:
	docker compose -f srcs/docker-compose.yml up -d --build

down:
	docker compose -f srcs/docker-compose.yml down

clean:
	docker system prune -f

fclean: down clean
	rm -rf /home/ralba-ji/data

re: fclean all
