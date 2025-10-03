#include <fcgi_stdio.h>
#include <stdio.h>

int main(void) {
    while (FCGI_Accept() >= 0) {
        printf("Content-type: text/html\r\n\r\n");
        printf("<html><head><title>Hello</title></head><body>");
        printf("<h1>Hello, World!</h1>");
        printf("</body></html>\n");
    }
    return 0;
}
