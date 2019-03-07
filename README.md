# docker-gradle-sencha
Dockerfile mixing gradle and sencha

Mostly a union of https://github.com/keeganwitt/docker-gradle (jdk 8)and a sencha cmd installation.

## Usage

Enter into project directory and then run:

```
docker run --rm  -v "$PWD":/project -w /project docker-gradle-sencha:latest gradle build
```

If you have a gradle wrapper in place, you can just:
```
docker run --rm  -v "$PWD":/project -w /project docker-gradle-sencha:latest ./gradlew build
```
