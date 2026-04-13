#include <windows.h>
#include <stdio.h>

void search(const char *basePath, const char *keyword) {
    char path[MAX_PATH];
    WIN32_FIND_DATA findData;

    snprintf(path, MAX_PATH, "%s\\*", basePath);

    HANDLE hFind = FindFirstFile(path, &findData);
    if (hFind == INVALID_HANDLE_VALUE) return;

    do {
        if (strcmp(findData.cFileName, ".") == 0 ||
            strcmp(findData.cFileName, "..") == 0)
            continue;

        char fullPath[MAX_PATH];
        snprintf(fullPath, MAX_PATH, "%s\\%s", basePath, findData.cFileName);

        // Match filename
        if (strstr(findData.cFileName, keyword)) {
            printf("%s\n", fullPath);
        }

        // Recurse into directories
        if (findData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) {
            search(fullPath, keyword);
        }

    } while (FindNextFile(hFind, &findData));

    FindClose(hFind);
}

int main() {
    char keyword[256];

    printf("Enter search term: ");
    scanf("%255s", keyword);

    search("C:", keyword);

    return 0;
}
