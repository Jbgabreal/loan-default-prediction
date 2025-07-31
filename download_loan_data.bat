@echo off
setlocal

echo == Installing Kaggle CLI ==
pip install kaggle >nul 2>&1

echo == Creating .kaggle folder if it doesn't exist ==
if not exist %USERPROFILE%\.kaggle (
    mkdir %USERPROFILE%\.kaggle
    echo 📌 NOTE: Move your kaggle.json into %USERPROFILE%\.kaggle before proceeding.
)

echo == Downloading dataset from Kaggle ==
kaggle datasets download -d itsmesunil/bank-loan-modelling -p data

if exist "data\bank-loan-modelling.zip" (
    echo ✅ Download complete.
) else (
    echo ❌ Download failed. Exiting...
    pause
    exit /b
)

echo == Unzipping dataset ==
powershell -command "Expand-Archive -Path 'data\\bank-loan-modelling.zip' -DestinationPath 'data' -Force"

:: Wait a second to ensure files are extracted
timeout /t 1 >nul

:: Rename the first Excel file found to loan_data.xlsx
for %%f in (data\*.xlsx) do (
    echo ✅ Found %%~nxf — renaming it to loan_data.xlsx
    move "%%f" "data\loan_data.xlsx" >nul
    goto :done
)

echo ⚠️ No Excel file found to rename.

:done
echo ✅ Done. Your dataset is now at: data\loan_data.xlsx
pause
