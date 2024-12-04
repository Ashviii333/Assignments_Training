document.getElementById('calculateBtn').addEventListener('click', function () {
    const loanAmount = parseFloat(document.getElementById('loanAmount').value);
    const monthlySalary = parseFloat(document.getElementById('monthlySalary').value);
    const loanDuration = parseInt(document.getElementById('loanDuration').value) * 12; // Convert years to months
    const interestRate = parseFloat(document.getElementById('interestRate').value) / 12 / 100; // Monthly interest rate
    const loanType = document.getElementById('loanType').value;

    // Check all fields are filled
    if (isNaN(loanAmount) || isNaN(monthlySalary) || isNaN(loanDuration) || isNaN(interestRate) || loanType === '') {
        alert('Please fill out all fields correctly.');
        return;
    }

    // EMI Calculation Formula
    const emi = (loanAmount * interestRate * Math.pow(1 + interestRate, loanDuration)) / (Math.pow(1 + interestRate, loanDuration) - 1);

    const emiRounded = emi.toFixed(2);

    document.getElementById('emiResult').textContent = `For a ${loanType}, your monthly EMI is ₹${emiRounded}.`;


    const adviceElement = document.getElementById('advice');    //Advice generation

    if (emi > monthlySalary * 0.5) {
        adviceElement.textContent = 'EMI exceeds 50% of your salary. Consider increasing the loan duration.';
        adviceElement.className = 'advice-red'; // Apply red text style
    } else {
        adviceElement.textContent = 'EMI is less than 50% of your monthly salary. You may opt for it.';
        adviceElement.className = 'advice-green'; // Apply green text style
    }
});
