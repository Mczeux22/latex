#!/bin/bash

# ==========================================
# SCRIPT DE SAUVEGARDE AUTOMATIQUE (TP FAC)
# ==========================================

# 1. Vérifier si on est bien dans un dépôt Git
if [ ! -d ".git" ]; then
    echo "❌ Erreur : Ce dossier n'est pas un dépôt Git."
    exit 1
fi

# 2. Vérifier s'il y a des modifications à sauvegarder
if git diff --quiet && git diff --cached --quiet && [ -z "$(git status --porcelain)" ]; then
    echo "✨ Rien à sauvegarder, tout est déjà à jour !"
    exit 0
fi

# 3. Ajouter tous les changements (nouveaux fichiers, modifications, suppressions)
echo "📦 Ajout des fichiers..."
git add -A

# 4. Créer le message de commit avec la date actuelle
DATE_HEURE=$(date "+%d/%m/%Y à %H:%M")
MESSAGE_COMMIT="Sauvegarde auto fac le $DATE_HEURE"

echo "✍️  Création du commit : \"$MESSAGE_COMMIT\"..."
git commit -m "$MESSAGE_COMMIT"

# 5. Envoyer sur GitHub (récupère automatiquement le nom de la branche actuelle)
BRANCHE_ACTUELLE=$(git branch --show-current)
echo "🚀 Envoi vers GitHub (branche : $BRANCHE_ACTUELLE)..."

if git push origin "$BRANCHE_ACTUELLE"; then
    echo "✅ Succès ! Votre travail est en sécurité sur GitHub."
else
    echo "❌ Échec de l'envoi. Vérifiez votre connexion."
fi

