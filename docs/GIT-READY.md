Preparación para Git 3.0 y mejores prácticas

Puntos aplicados en este repo:
- `.gitattributes` para normalizar line endings y marcar archivos binarios para Git LFS.
- `.editorconfig` para mantener formato consistente entre plataformas.
- Uso de Git LFS para `assets/poni` (imágenes, GIF, XCFs).

Recomendaciones adicionales antes de subir a ramas compartidas:
1. Asegúrate de que todos tus colaboradores instalen Git LFS: `git lfs install`.
2. Habilitar CI que verifique formateo y `.gitattributes` (por ejemplo GitHub Actions).
3. Validar que los binarios grandes están en LFS mediante `git lfs ls-files`.
4. Revisar HISTORY y usar `git mv` para conservar historial al reorganizar.

Notas:
 - Git 3.0 puede introducir cambios en el comportamiento por defecto (configuración de line endings u otras), con estas medidas el repo está preparado para una transición suave.

How to rename the default branch (master -> main):
- Create a backup branch:
  git branch backup/master-before-main
  git push origin backup/master-before-main
- Create 'main' branch and push:
  git checkout master
  git branch main
  git push -u origin main
- Change default branch in GitHub Settings > Branches (or run 'gh' commands) and delete the old 'master' branch only after ensuring 'main' is set as default.

Recommended Git version:
- Keep Git updated; using a recent stable Git (e.g., >= 2.40) is recommended to ensure compatibility with modern features.

