# poa

Se creo 5 ramas:

La rama -> "master" --- Esta rama es la principal

La rama -> "esmir" --- Esta rama es del usuario Esmir

La rama -> "joselyn" --- Esta rama es del usuario Joselyn

La rama -> "carlos" --- Esta rama es del usuario Carlos

La rama -> "joel" --- Esta rama es del usuario Joel

La finalidad de la creación de de las ramas por usuario es para que cada quien suba sus cambios del proyecto a su rama y el administrador
se encargara de unificar las ramas de los usuarios con la rama principal "master".

# Clonar el Proyecto

Para el usuario Joselyn

git clone -b joselyn git@github.com:esmircm/poa.git

Para el usuario Carlos

git clone -b carlos git@github.com:esmircm/poa.git

Para el usuario Joel

git clone -b joel git@github.com:esmircm/poa.git

# Lista de comando git

git status  -> Muestra los archivos modificados localmente

git add -> añade los archivos que se han modificado y por ende se muestran despues del git status

git commit -m "comentario que quieran" -> este comando simplemente añade un comentario sobre los archivos que estas subiendo.

git push origin nombre_rama -> sube los archivos añadidos a la rama especificada.

# git push segun la rama

Para el usuario Joselyn

git push origin joselyn

Para el usuario Carlos

git push origin carlos

Para el usuario Joel

git push origin joel

# Comando para bajar cambio (actualizar proyecto localmente)

git pull origin master

Nota: se hara siempre git pull a la rama "master" para así obtener las ultimas modificaciones añadidas a esta rama principal.


 






