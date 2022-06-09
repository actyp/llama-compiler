#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

/***** type definitions *****/
typedef int64_t int_t;
typedef int8_t char_t;
typedef int8_t bool_t;
typedef float float_t;
typedef int8_t unit_t;
typedef int64_t* int_ref_t;

typedef struct {
    char_t *string;
    int_t size;
} *array_of_char;

/* unit value */
unit_t unit_value = 0;

/***** IO functions *****/
int_t lla_read_int(unit_t u) {
    int_t i;
    scanf("%ld", &i);
    return i;
}

unit_t lla_print_int(int_t i) {
    printf("%ld", i);
    return unit_value;
}

char_t lla_read_char(unit_t u) {
    char_t c;
    scanf("%c", &c);
    return c;
}

unit_t lla_print_char(char_t c) {
    printf("%c", c);
    return unit_value;
}

bool_t lla_read_bool(unit_t u) {
    char_t read_char;
    // read first char
    scanf("%c", &read_char);
    if (read_char == 't') {
        // buffer for "rue\00"
        char_t buffer[4];
        scanf("%3s", buffer);
        // return true if buffer holds "rue"
        return strcmp(buffer, "rue") == 0;
    } if (read_char == 'f') {
        // buffer for "alse\00"
        char_t buffer[5];
        scanf("%4s", buffer);
        // return false
        return 0;
    } else {
        // read_char is neither 't' or 'f'
        // stop consuming and return false
        return 0;
    }
}

unit_t lla_print_bool(bool_t b) {
    printf("%s", b ? "true" : "false");
    return unit_value;
}

float_t lla_read_float(unit_t u) {
    float_t f;
    scanf("%f", &f);
    return f;
}

unit_t lla_print_float(float_t f) {
    printf("%f", f);
    return unit_value;
}

unit_t lla_read_string(array_of_char ac) {
    fgets(ac->string, ac->size, stdin);
    // discard the possible trailing newline
    int_t last_idx = strlen(ac->string) - 1;
    if (ac->string[last_idx] == '\n') {
      ac->string[last_idx] = '\0';
    }
    return unit_value;
}

unit_t lla_print_string(array_of_char ac) {
    printf("%s", ac->string);
    return unit_value;
}

/***** Mathematical functions *****/
int_t lla_abs(int_t i) {
    return (int_t) abs(i);
}

float_t lla_fabs(float_t f) {
    return (float_t) fabsf(f);
}

float_t lla_sqrt(float_t f) {
    return (float_t) sqrtf(f);
}

float_t lla_sin(float_t f) {
    return (float_t) sinf(f);
}

float_t lla_cos(float_t f) {
    return (float_t) cosf(f);
}

float_t lla_tan(float_t f) {
    return (float_t) tanf(f);
}

float_t lla_atan(float_t f) {
    return (float_t) atanf(f);
}

float_t lla_exp(float_t f) {
    return (float_t) expf(f);
}

float_t lla_ln(float_t f) {
    return (float_t) logf(f);
}

float_t lla_pi(unit_t u) {
    return (float_t) M_PI;
}

/***** Incremental functions *****/
unit_t lla_incr(int_ref_t i_ref) {
    (*i_ref)++;
    return unit_value;
}

unit_t lla_decr(int_ref_t i_ref) {
    (*i_ref)--;
    return unit_value;
}

/***** Conversion functions *****/
float_t lla_float_of_int(int_t i) {
    return (float_t) i;
}

int_t lla_int_of_float(float_t f) {
    return (int_t) f;
}

int_t lla_round(float_t f) {
    return (int_t) roundf(f);
}

int_t lla_int_of_char(char_t c) {
    return (int_t) c;
}

char_t lla_char_of_int(int_t i) {
    return (char_t) i;
}

/***** String management functions *****/
int_t lla_strlen(array_of_char ac) {
    return (int_t) strlen(ac->string);
}

int_t lla_strcmp(array_of_char ac1, array_of_char ac2) {
    return (int_t) strcmp(ac1->string, ac2->string);
}

unit_t lla_strcpy(array_of_char dest, array_of_char src) {
    strcpy(dest->string, src->string);
    dest->size = src->size;
    return unit_value;
}

unit_t lla_strcat(array_of_char dest, array_of_char src) {
    strcat(dest->string, src->string);
    // compute only one '\00'
    dest->size += src->size - 1;
    return unit_value;
}

/***** Inner util functions *****/
/* used by operator '**' */
float_t lla_pow(float_t base, float_t exp) {
    return (float_t) powf(base, exp);
}

unit_t lla_exit_with_error(array_of_char error_ac, int_t code) {
    printf("%s", error_ac->string);
    exit(code);
    return unit_value;
}
