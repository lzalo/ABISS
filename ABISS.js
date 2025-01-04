const { execSync } = require('child_process');
const readline = require('readline');

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

// Function to clear the console screen
function clearScreen() {
    process.stdout.write('\x1Bc');
}

// Function to display the banner
function displayBanner() {
    console.log("* Make Sure That You Ran ABISS As Admin *\n");
    console.log("    ▄████████ ▀█████████▄   ▄█     ▄████████    ▄████████ ");
    console.log("   ███    ███   ███    ███ ███    ███    ███   ███    ███ ");
    console.log("   ███    ███   ███    ███ ███▌   ███    █▀    ███    █▀  ");
    console.log("   ███    ███  ▄███▄▄▄██▀  ███▌   ███          ███        ");
    console.log(" ▀███████████ ▀▀███▀▀▀██▄  ███▌ ▀███████████ ▀███████████ ");
    console.log("   ███    ███   ███    ██▄ ███           ███          ███ ");
    console.log("   ███    ███   ███    ███ ███     ▄█    ███    ▄█    ███ ");
    console.log("   ███    █▀  ▄█████████▀  █▀    ▄████████▀   ▄████████▀  \n");
}

// Function to display the menu
function displayMenu() {
    console.log("             ╦");
    console.log("             ║");
    console.log("             ╠═ Add A User");
    console.log("             ║");
    console.log("             ╠═ List Users");
    console.log("             ║");
    console.log("             ╠═ Change A Users Password");
    console.log("             ║");
    console.log("             ╠═ Exit");
    console.log("             ╩\n");
}

// Function to list users
function listUsers() {
    try {
        const output = execSync('net user').toString();
        console.log(output);
    } catch (error) {
        console.log("Error: Could not list users.");
    }
}

// Function to add a user
function addUser() {
    rl.question('Username: ', (username) => {
        rl.question('Password: ', (password) => {
            try {
                execSync(`net user ${username} ${password} /Add`);
                console.log(`Successfully created user: ${username} with Password: ${password}`);
                mainMenu();
            } catch (error) {
                console.log('Error: Could not add user.');
                mainMenu();
            }
        });
    });
}

// Function to change user password
function changeUserPassword() {
    rl.question('Username: ', (username) => {
        rl.question('New Password: ', (newPassword) => {
            try {
                execSync(`net user ${username} ${newPassword}`);
                console.log(`Successfully changed ${username}'s password to ${newPassword}`);
                mainMenu();
            } catch (error) {
                console.log('Error: Could not change password.');
                mainMenu();
            }
        });
    });
}

// Main function to handle menu options
function mainMenu() {
    displayBanner();
    displayMenu();
    rl.question('Select an option: ', (option) => {
        switch (option) {
            case '1':
                addUser();
                break;
            case '2':
                listUsers();
                break;
            case '3':
                changeUserPassword();
                break;
            case '4':
                console.log('Exiting...');
                rl.close();
                break;
            default:
                console.log('Invalid option. Please try again.');
                mainMenu();
        }
    });
}

// Start the program
clearScreen();
mainMenu();
