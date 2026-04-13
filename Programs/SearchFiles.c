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
    char basePath[MAX_PATH];

    printf("Enter search term: ");
    if (!fgets(keyword, sizeof(keyword), stdin)) {
        printf("Input error.\n");
        return 1;
    }
    keyword[strcspn(keyword, "\n")] = 0;

    if (strlen(keyword) == 0) {
        printf("Empty keyword not allowed.\n");
        return 1;
    }

    printf("Enter base path (e.g. C:\\ or C:\\Users): ");
    if (!fgets(basePath, sizeof(basePath), stdin)) {
        printf("Input error.\n");
        return 1;
    }
    basePath[strcspn(basePath, "\n")] = 0;

    if (strlen(basePath) == 0) {
        printf("Empty path not allowed.\n");
        return 1;
    }

    // Optional: normalize trailing slash for safety
    size_t len = strlen(basePath);
    if (basePath[len - 1] != '\\' && len < MAX_PATH - 2) {
        basePath[len] = '\\';
        basePath[len + 1] = '\0';
    }

    printf("\nSearching...\n\n");
    search(basePath, keyword);

    return 0;
}
