#include <string>

std::string TrimCompat(const std::string& s)
    __asm__("_ZN7android4base4TrimERKNSt3__112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEE");

std::string TrimCompat(const std::string& s) {
    size_t start = s.find_first_not_of(" \t\n\r\v\f");
    if (start == std::string::npos)
        return "";

    size_t end = s.find_last_not_of(" \t\n\r\v\f");
    return s.substr(start, end - start + 1);
}
