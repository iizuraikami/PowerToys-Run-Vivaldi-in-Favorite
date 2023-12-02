// Copyright (c) Davide Giacometti. All rights reserved.
// Licensed under the MIT license. See LICENSE file in the project root for full license information.

using Community.PowerToys.Run.Plugin.ChromeFavorite.Models;

namespace Community.PowerToys.Run.Plugin.ChromeFavorite.Helpers
{
    public interface IFavoriteProvider
    {
        FavoriteItem Root { get; }
    }
}
