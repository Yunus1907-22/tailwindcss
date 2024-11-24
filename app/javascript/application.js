import "@hotwired/turbo-rails";
import "controllers";
import "intl-tel-input";







function initIntlTelInput() {
    const input = document.querySelector("#phone"); // Select the phone input field
    if (input) {
        // Check if it's already initialized to avoid double initialization
        if (input.intlTelInput) {
            input.intlTelInput.destroy(); // Destroy any previous instance
        }

        // Initialize intl-tel-input
        const iti = window.intlTelInput(input, {
            initialCountry: "us", // Default to US
            preferredCountries: ["us", "de", "cn"], // Preferred countries
            utilsScript: "https://cdn.jsdelivr.net/npm/intl-tel-input@17.0.8/build/js/utils.js", // Utils script
            nationalMode: false, // Use full international format
        });

        // Handle changes to phone number input
        input.addEventListener("change", function () {
            const fullPhoneNumber = iti.getNumber(); // Get the number with country code
            document.querySelector("#expert_telefon_number").value = fullPhoneNumber; // Update hidden input
        });

        // Save the instance for reference in case of future reinitialization
        input.intlTelInput = iti;
    }



    
}




// Event listeners for Turbo navigation events
document.addEventListener("turbo:load", initIntlTelInput);
document.addEventListener("turbo:frame-load", initIntlTelInput);
document.addEventListener("turbo:render", initIntlTelInput);