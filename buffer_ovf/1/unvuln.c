#include <stdio.h>
#include <string.h>

int main (int argc, char** argv)
{
    char buffer[500];
    strncpy(buffer, argv[1], sizeof(buffer));

    return 0;
}
