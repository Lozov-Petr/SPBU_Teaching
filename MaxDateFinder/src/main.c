#include <stdio.h>
#include <stdbool.h>

#define FILE_PATH "file.txt"
#define DAY_LENGTH 2
#define MONTH_LENGTH 2
#define YEAR_MAX_LENGTH 9
#define MAX_DATE_LENGTH YEAR_MAX_LENGTH + MONTH_LENGTH + DAY_LENGTH + 2
#define SEPARATOR '.'

typedef struct
{
    unsigned short day;
    unsigned short month;
    unsigned int year;
    char stringRepresentation[MAX_DATE_LENGTH];
    size_t currentLenght;
} Date;

Date getMaxDate(Date date1, Date date2)
{
    if (date1.year > date2.year)
    {
        return date1;
    }

    if (date1.year == date2.year && date1.month > date2.month)
    {
        return date1;
    }

    if (date1.year == date2.year && date1.month == date2.month && date1.day > date2.day)
    {
        return date1;
    }

    return date2;
}

bool isValidDate(Date date)
{
    if (date.year == 0 || date.month == 0 || date.month > 12 || date.day == 0)
    {
        return false;
    }

    if (date.month == 2)
    {
        if (date.year % 4 == 0)
        {
            return date.day <= 29;
        }

        return date.day <= 28;
    }

    if (date.month % 2 == 1)
    {
        return date.day <= 31;
    }

    return date.day <= 30;
}

bool isDigit(int character)
{
    return character >= '0' && character <= '9';
}

bool isDot(int character)
{
    return character == SEPARATOR;
}

void clearDate(Date *date)
{
    date->day = 0;
    date->month = 0;
    date->year = 0;

    for (size_t i = 0; i <= date->currentLenght; ++i)
    {
        date->stringRepresentation[i] = 0;
    }

    date->currentLenght = 0;
}

bool updateDate(Date *date, char character)
{
    size_t currentStep = date->currentLenght;
    date->stringRepresentation[currentStep] = character;
    ++(date->currentLenght);

    if (date->currentLenght >= MAX_DATE_LENGTH)
    {
        clearDate(date);
        return false;
    }

    if (currentStep < DAY_LENGTH)
    {
        if (isDigit(character))
        {
            date->day = date->day * 10 + character - '0';
            return true;
        }

        clearDate(date);
        return false;
    }

    if (currentStep > DAY_LENGTH && currentStep <= DAY_LENGTH + MONTH_LENGTH && isDigit(character))
    {
        if (isDigit(character))
        {
            date->month = date->month * 10 + character - '0';
            return true;
        }

        clearDate(date);
        return false;
    }

    if (currentStep > DAY_LENGTH + MONTH_LENGTH + 1)
    {
        if (isDigit(character))
        {
            date->year = date->year * 10 + character - '0';
            return true;
        }

        clearDate(date);
        return false;
    }

    if (isDot(character))
    {
        return true;
    }

    clearDate(date);
    return false;
}

int getMaxDateFromFile(FILE *inputFile, Date *maxDate)
{
    Date currentDate = {};
    bool wasFirstDate = false;
    char currentChar = fgetc(inputFile);

    while (currentChar != EOF)
    {
        updateDate(&currentDate, currentChar);

        currentChar = fgetc(inputFile);

        if (currentDate.currentLenght > 6 && !isDigit(currentChar) && isValidDate(currentDate))
        {
            wasFirstDate = true;
            *maxDate = getMaxDate(*maxDate, currentDate);
        }
    }

    return !wasFirstDate;
}

void main()
{
    FILE *file = fopen(FILE_PATH, "r");
    if (file == NULL)
    {
        printf("File \"%s\" connot be opened.\n", FILE_PATH);
        return;
    }

    Date maxDate = {};
    int errorCode = getMaxDateFromFile(file, &maxDate);

    if (errorCode != 0)
    {
        printf("File \"%s\" doesn't contain any dates.\n", FILE_PATH);
        return;
    }

    printf("Maximum date in file \"%s\" is %s.\n", FILE_PATH, maxDate.stringRepresentation);
}