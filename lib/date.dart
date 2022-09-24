

import 'models/cotegare.dart';
import 'models/mails.dart';

const DUMMY_CATEGORIES = [
  Cotegare(
    id: 'c1',
    imagePath: 'https://www.lux-review.com/wp-content/uploads/2020/03/pasta-pomodoro.jpg',

  ),
  Cotegare(
    id: 'c2',
    imagePath:
      'https://static01.nyt.com/images/2021/08/19/dining/24-easy-quick-dinner-recipes-1632175796332/24-easy-quick-dinner-recipes-1632175796332-superJumbo.jpg'
  ),
  Cotegare(
    id: 'c3',
    imagePath:
'https://thumbs.dreamstime.com/b/bacon-cheese-burger-plate-homemade-brioche-bun-red-wooden-log-background-114385327.jpg',
  ),
  Cotegare(
    id: 'c4',
    imagePath:
    'https://thatanxioustraveller.com/wp-content/uploads/2018/05/germany_sauerkraut_1.jpg',
  ),
  Cotegare(
    id: 'c5',
    imagePath:
'https://eadn-wc02-3894996.nxedge.io/wp-content/uploads/2016/04/bibimbap-1.jpg',
  ),
  Cotegare(
    id: 'c6',
    imagePath:
    'https://sesamedisk.com/wp-content/uploads/2021/10/shutterstock_741885331-1024x683.jpeg',
  ),
  Cotegare(
    id: 'c7',
    imagePath:
'https://cdn.apartmenttherapy.info/image/upload/f_jpg,q_auto:eco,c_fill,g_auto,w_1500,ar_4:3/k%2Farchive%2Fb3218cfc33905defa99e62af055b76e171aa4ec1'
  ),
  Cotegare(
    id: 'c8',
    imagePath:
'https://res.cloudinary.com/rainforest-cruises/images/c_fill,g_auto/f_auto,q_auto/v1620067036/Southeast-Asian-Food-Cambodian-Amok/Southeast-Asian-Food-Cambodian-Amok.jpg',
  ),
  Cotegare(
    id: 'c9',
    imagePath:
    'https://www.chicagotribune.com/resizer/lJWi7IYyHZCCacKB1I0eaIS2gng=/1200x630/filters:format(jpg):quality(70)/www.trbimg.com/img-5cc9be8b/turbine/ct-food-viz-chicago-best-french-food-0430',
  ),
  Cotegare(
    id: 'c10',
    imagePath: 'https://food.fnr.sndimg.com/content/dam/images/food/unsized/2015/5/19/0/fnd_foodlets-pb-j-wrap.jpg',
  ),
];

const DUMMY_MEALS = [
  Mail(
    id: 'm1',
    categories: [
      'c1',
      'c2',
    ],
    affordability: Affordability.Affordable,
    complexity: Complexity.Simple,
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg/800px-Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg',
    duration: 20,
    inGlutenFree: false,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
  ),
  Mail(
    id: 'm2',
    categories: [
      'c2',
    ],
    affordability: Affordability.Affordable,
    complexity: Complexity.Simple,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg',
    duration: 10,
    inGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
  ),
  Mail(
    id: 'm3',
    categories: [
      'c2',
      'c3',
    ],
    affordability: Affordability.Pricey,
    complexity: Complexity.Simple,
    imageUrl:
        'https://cdn.pixabay.com/photo/2014/10/23/18/05/burger-500054_1280.jpg',
    duration: 45,
    inGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
  ),
  Mail(
    id: 'm4',
    categories: [
      'c4',
    ],
    affordability: Affordability.Luxurions,
    complexity: Complexity.Challenging,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/03/31/19/29/schnitzel-3279045_1280.jpg',
    duration: 60,
    inGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
  ),
  Mail(
    id: 'm5',
    categories: [
      'c2'
          'c5',
      'c10',
    ],
    affordability: Affordability.Luxurions,
    complexity: Complexity.Simple,
    imageUrl:
        'https://cdn.pixabay.com/photo/2016/10/25/13/29/smoked-salmon-salad-1768890_1280.jpg',
    duration: 15,
    inGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: true,
  ),
  Mail(
    id: 'm6',
    categories: [
      'c6',
      'c10',
    ],
    affordability: Affordability.Affordable,
    complexity: Complexity.Hard,
    imageUrl:
        'https://cdn.pixabay.com/photo/2017/05/01/05/18/pastry-2274750_1280.jpg',
    duration: 240,
    inGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
  ),
  Mail(
    id: 'm7',
    categories: [
      'c7',
    ],
    affordability: Affordability.Affordable,
    complexity: Complexity.Simple,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/07/10/21/23/pancake-3529653_1280.jpg',
    duration: 20,
    inGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
  ),
  Mail(
    id: 'm8',
    categories: [
      'c8',
    ],
    affordability: Affordability.Pricey,
    complexity: Complexity.Challenging,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/06/18/16/05/indian-food-3482749_1280.jpg',
    duration: 35,
    inGlutenFree: true,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
  ),
  Mail(
    id: 'm9',
    categories: [
      'c9',
    ],
    affordability: Affordability.Affordable,
    complexity: Complexity.Hard,
    imageUrl:
        'https://cdn.pixabay.com/photo/2014/08/07/21/07/souffle-412785_1280.jpg',
    duration: 45,
    inGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
  ),
  Mail(
    id: 'm10',
    categories: [
      'c2',
      'c5',
      'c10',
    ],
    affordability: Affordability.Luxurions,
    complexity: Complexity.Simple,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/04/09/18/26/asparagus-3304997_1280.jpg',
    duration: 30,
    inGlutenFree: true,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
  ),
];
