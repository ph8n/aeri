#pragma once
#include <cstdint>

namespace aeri::core
{

using Tick = int64_t;

struct Price
{
    Tick v;
};

struct Quantity
{
    Tick v;
};

} // namespace aeri::core
