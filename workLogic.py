import subprocess

def launch_steam_game(app_id):
    steam_path = "C:\\Program Files (x86)\\Steam\\Steam.exe"
    
    # Формируем команду для запуска игры
    command = [steam_path, f"steam://rungameid/{app_id}"]
    
    try:
        # Запускаем игру через subprocess
        subprocess.run(command, check=True)
        print(f"Игра с App ID {app_id} запущена успешно.")
    except subprocess.CalledProcessError as e:
        print(f"Ошибка при запуске игры: {e}")


def launch_application(app_path):
    try:
        subprocess.run(app_path, check=True)
        print("Приложение запущено!")
    except subprocess.CalledProcessError as e:
        print(f"Ошибка при запуске приложения: {e}")

def kill_task(process_name: str):
    result = subprocess.run(f"taskkill /f /im {process_name}", shell=True)

    if result.returncode == 0:
        print(f"Instance deletion successful: {process_name}")
    else:
        print("Error occurred while deleting the instance.")



# if __name__ == "__main__":
#     app_id = 322170  
#     launch_steam_game(app_id)