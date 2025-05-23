#!/bin/bash

# =============================================
# Название: example_script.sh
# Описание: Шаблон bash-скрипта с блоками и логикой
# Автор: ilya
# Дата: 2025-05-05
# Версия: 1.0
# =============================================

# ---------------------------------------------
# 0. Глобальные переменные
# ---------------------------------------------
SOURCE_DIR="/home/user"
BACKUP_DIR="/backup"
LOG_FILE="/var/log/script.log"

# ---------------------------------------------
# 1. Функции
# ---------------------------------------------

# Логирование сообщений в файл
log_message() {
    local MESSAGE="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $MESSAGE" >> "$LOG_FILE"
}

# Проверка существования директории
check_directory() {
    local DIR="$1"
    if [ ! -d "$DIR" ]; then
        log_message "Директория $DIR не найдена. Завершение."
        echo "Ошибка: директория $DIR не найдена"
        exit 1
    fi
}

# Создание резервной копии
create_backup() {
    local FILE_NAME="backup-$(date +%F).tar.gz"
    tar -czf "$BACKUP_DIR/$FILE_NAME" "$SOURCE_DIR"
    log_message "Создан архив: $FILE_NAME"
}

# ---------------------------------------------
# 2. Основная логика
# ---------------------------------------------

# Проверка директорий
check_directory "$SOURCE_DIR"
check_directory "$BACKUP_DIR"

# Создание бэкапа
create_backup

# ---------------------------------------------
# 3. Завершение
# ---------------------------------------------
echo "Скрипт завершён успешно."
log_message "Скрипт выполнен успешно."
