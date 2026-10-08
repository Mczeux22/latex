#!/bin/bash

# Supprime tous les fichiers SAUF les .tex et les .sh (le script)
find . -type f ! -name "*.tex" ! -name "*.sh" -delete

# Supprime les répertoires devenus vides
find . -type d -empty -delete

