import os
import subprocess

def clear_screen():
    # Clear screen for different OS
    os.system('cls' if os.name == 'nt' else 'clear')

def display_banner():
    print("* Make Sure That You Ran ABISS As Admin *")
    print("\n")
    print("    ▄████████ ▀█████████▄   ▄█     ▄████████    ▄████████ ")
    print("   ███    ███   ███    ███ ███    ███    ███   ███    ███ ")
    print("   ███    ███   ███    ███ ███▌   ███    █▀    ███    █▀  ")
    print("   ███    ███  ▄███▄▄▄██▀  ███▌   ███          ███        ")
    print(" ▀███████████ ▀▀███▀▀▀██▄  ███▌ ▀███████████ ▀███████████ ")
    print("   ███    ███   ███    ██▄ ███           ███          ███ ")
    print("   ███    ███   ███    ███ ███     ▄█    ███    ▄█    ███ ")
    print("   ███    █▀  ▄█████████▀  █▀    ▄████████▀   ▄████████▀  ")
    print("\n")

def display_menu():
    print("             ╦")
    print("             ║")
    print("             ╠═ Add A User")
    print("             ║")
    print("             ╠═ List Users")
    print("             ║")
    print("             ╠═ Change A Users Password")
    print("             ║")
    print("             ╠═ Exit")
    print("             ╩")
    print("\n")

def list_users():
    subprocess.run("net user", shell=True)

def add_user():
    username = input("Username: ")
    password = input("Password: ")
    subprocess.run(f'net user {username} {password} /Add', shell=True)
    print(f"Successfully created user: {username} with Password: {password}")

def change_user_password():
    username = input("Username: ")
    new_password = input("New Password: ")
    subprocess.run(f'net user {username} {new_password}', shell=True)
    print(f"Successfully changed {username}'s password to {new_password}")

def main():
    clear_screen()
    display_banner()
    while True:
        display_menu()
        option = input("Select an option: ")
        if option == "1":
            add_user()
        elif option == "2":
            list_users()
        elif option == "3":
            change_user_password()
        elif option == "4":
            break
        else:
            print("Invalid option. Please try again.")
        input("\nPress Enter to continue...")  # Pause before next menu

if __name__ == "__main__":
    main()
